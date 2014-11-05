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
  def shopping_list_pdf
    shopping_list = ingredients.map do |ingredient|
      [ingredient.name, ingredient.quantity]
    end

    pdf = Prawn::Document.new
    pdf.table([[ "Item", "Quantity" ], *shopping_list]) do |t|
      t.header = true
      t.row_colors = [ "aaaaff", "aaffaa", "ffaaaa" ]
      t.row(0).style :background_color => '448844', :text_color => 'ffffff'
      t.columns(1).align = :right
    end
    pdf.render
  end
end
