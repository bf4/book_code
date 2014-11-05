#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddUsersAndRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.column :title, :string
      t.column :instructions, :text
      t.column :author_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime      
    end
    
    create_table :ingredients do |t|
      t.column :recipe_id, :integer      
      t.column :name, :string
      t.column :unit, :string
      t.column :amount, :float
    end                      

    create_table :users do |t|
      t.column :name, :string
      t.column :password, :string 
    end
  end

  def self.down
    drop_table :recipes
    drop_table :ingredients
    drop_table :users
  end
end
