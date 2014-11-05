#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new(:ingredients => [Ingredient.new])
  end
  def new_prealloc
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to recipes_url, :notice => "You added a recipe"
    else
      render :new
    end

  end

end
