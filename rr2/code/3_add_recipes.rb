#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddRecipes < ActiveRecord::Migration
  def self.up
    create_table "recipes" do |t|
      t.column "name", :string
      t.column "region", :string
      t.column "instructions", :text
    end
    create_table "ingredients" do |t|
      t.column "recipe_id", :integer
      t.column "name", :string
      t.column "unit", :string
      t.column "quantity", :integer
    end
  end

  def self.down
    remove_table "recipes"
    remove_table "ingredients"
  end
end
