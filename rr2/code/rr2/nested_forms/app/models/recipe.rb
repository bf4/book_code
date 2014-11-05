#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Recipe < ActiveRecord::Base
  has_many :ingredients
end
class Recipe
  accepts_nested_attributes_for :ingredients
  def with_blank_ingredients(n = 5)
    n.times do
      ingredients.build
    end
    self
  end
end
