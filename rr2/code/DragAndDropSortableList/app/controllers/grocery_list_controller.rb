#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class GroceryListController < ApplicationController
  layout "standard"
  
  def show
    @grocery_list = GroceryList.find(params[:id])
  end                                            
  # ...
  def sort
    @grocery_list = GroceryList.find(params[:id])
    @grocery_list.food_items.each do |food_item|
      food_item.position = params['grocery-list'].index(food_item.id.to_s) + 1
      food_item.save
    end
    render :nothing => true
  end              
end
