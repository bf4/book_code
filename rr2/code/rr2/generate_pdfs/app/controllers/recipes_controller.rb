#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class RecipesController < ApplicationController
  def shopping_list
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        send_data @recipe.shopping_list_pdf,
                  content_type: Mime::PDF
      end
    end
  end

end
