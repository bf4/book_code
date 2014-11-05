#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddPersonAndGroceryListsAndFoodItemsTables < ActiveRecord::Migration
  def self.up 
    create_table :people do |t|
      t.column :name, :string
    end
    
    create_table :grocery_lists do |t|
      t.column :name, :string
      t.column :person_id, :integer
    end
    
    create_table :food_items do |t|
      t.column :grocery_list_id, :integer
      t.column :position, :integer
      t.column :name, :string
      t.column :quantity, :integer
    end
  end

  def self.down
    drop_table :people
    drop_table :grocery_lists
    drop_table :food_items
  end
end
