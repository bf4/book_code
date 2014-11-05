#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddVersionedTables < ActiveRecord::Migration
  def self.up
    create_table("things") do |t|
      t.column :title, :text
    end
    Thing.create_versioned_table
  end
  
  def self.down
    Thing.drop_versioned_table
    drop_table "things" rescue nil
  end
end