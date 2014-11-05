#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart  = Cart.create
    @book_one = products(:ruby)
    @book_two  = products(:two)
  end
  
  test "add unique products" do
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_two.id).save!
    assert_equal 2, @cart.line_items.size
    assert_equal @book_one.price + @book_two.price, @cart.total_price
  end

  test "add duplicate product" do
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_one.id).save!
    assert_equal 2*@book_one.price, @cart.total_price
    assert_equal 1, @cart.line_items.size
    assert_equal 2, @cart.line_items[0].quantity
  end 
end
