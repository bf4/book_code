#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
recipe = Recipe.create!(name: "Sooper Shake")
[
  ["Carton of Goat Milk", 1],
  ["Head of Garlic", 2],
  ["Chocolate Bar", 9]
].each{|name, quantity| recipe.ingredients.create!(name: name, quantity: quantity)}

