#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  Factory.define :product do |product|
    product.name "A product"
    product.price 20
    product.listed_on 3.days.ago
  end
  test "A product with a price greater than zero is not free" do
    @product = Factory.build(:product)
    assert !@product.free?,
             "Should not have been free since it has a non-zero price"
  end
  test "A product not yet listed is not in stock" do
    @product = Factory.build(:product, :listed_on => 2.days.from_now)
    assert !@product.in_stock?,
           "Should not have been in stock since it's listed in the future"
  end

  test "it saves" do
    @product = Factory.create(:product)
    assert !@product.new_record?
  end

  Factory.factories.clear

  Factory.define :product do |product|
    product.name "A product"
    product.price 20
    product.listed_on 3.days.ago
    product.sku { |prod| [prod.name.gsub(/ /, '-').upcase, "-", rand(999)].join}
  end

  test "Demonstrating dynamically generated values" do
    @product = Factory.build(:product)
    assert_match /^A-PRODUCT-[0-9]+$/, @product.sku
  end
  Factory.factories.clear

  Factory.define :category do |category|
    category.name "Goods"
  end

  Factory.define :product do |product|
    product.name "A product"
    product.price 20
    product.listed_on 3.days.ago
    product.sku { |prod| [prod.name.gsub(/ /, '-').upcase, "-", rand(999)].join}
    product.category {|prod| prod.association(:category, :name => "Stuff")}
  end

  test "A product belongs to a category" do
    @product = Factory.build(:product)
    assert_equal "Stuff", @product.category.name
  end

Factory.define :not_yet_listed, :parent => :product do |product|
  product.listed_on 1.week.from_now
end
end
