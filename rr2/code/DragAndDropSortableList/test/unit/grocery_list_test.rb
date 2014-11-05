#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class GroceryListTest < Test::Unit::TestCase
  fixtures :grocery_lists

  # Replace this with your real tests.
  def test_truth
    assert_kind_of GroceryList, grocery_lists(:first)
  end
end
