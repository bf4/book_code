#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table "ingredients" do |t|
      t.column "recipe_id", :integer
      t.column "name", :string
      t.column "quantity", :integer
      t.column "unit_of_measurement", :string
    end

    create_table "ratings" do |t|
      t.column "recipe_id", :integer
      t.column "user_id", :integer
      t.column "rating", :integer
    end

    create_table "recipes" do |t|
      t.column "name", :string
      t.column "spice_level", :integer
      t.column "region", :string
      t.column "instructions", :text
    end
  end

  def self.down
    drop_table :ingredients
    drop_table :ratings
    drop_table :recipes
  end
end
