#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddAttributesToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :user_name, :string
    add_column :people, :name, :string 
    add_column :people, :password, :string    
   
  end

  def self.down          
    remove_column :people, :user_name
    remove_column :people, :name
    remove_column :people, :password    
  end
end
