#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
class Recipe < ActiveRecord::Base
  validates_presence_of :name, :cook_time_minutes

  has_many :ingredients
  def add_ingredient(amount, name)
    ingredients << Ingredient.create!({:amount => amount, :name => name})
  end

  def grocery_list
    list = Hash.new {0} 
    ingredients.each { |i| list[i.name] += i.amount }
    list.zip.collect { |i| i.first.reverse.join ' ' }.sort
  end
end
