#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_can_create_restaurant_with_only_name
    Restaurant.create! :name => "Mediterraneo"
  end

  def test_can_instantiate_and_save_a_restaurant
    restaurant = Restaurant.new
    restaurant.name = "Mediterraneo"
    restaurant.description = <<DESC
One of the best Italian restaurants in the Kings Cross area,
Mediterraneo will never leave you disappointed
DESC
    restaurant.address = "1244 Kings Cross Road, London WC1X 8CC"
    restaurant.phone = "+44 1432 3434"

    restaurant.save!
  end

  def test_that_name_is_required
    restaurant = Restaurant.new
    assert !restaurant.valid?
  end
end
