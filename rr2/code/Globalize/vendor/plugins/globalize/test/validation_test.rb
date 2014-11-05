#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class ValidationTest < Test::Unit::TestCase
  include Globalize

  fixtures :globalize_languages, :globalize_countries, 
    :globalize_translations, :globalize_products

  class Product < ActiveRecord::Base
    set_table_name "globalize_products"

    validates_length_of :name, :minimum => 5
    validates_length_of :specs, :maximum => 10
  end

  def setup
    Globalize::Locale.set("he-IL")
  end

  def test_max_validation
    prod = Product.find(2)
    assert !prod.valid?
    assert_equal "המפרט ארוך מדי (המקסימום הוא 10 תווים)", prod.errors.full_messages[1]

    prod = Product.find(3)
    assert !prod.valid?
    assert_equal "Name is too short (min is 5 characters)", prod.errors.full_messages.first 
  end
end
