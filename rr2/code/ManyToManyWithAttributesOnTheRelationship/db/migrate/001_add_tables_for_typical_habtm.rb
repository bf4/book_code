#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddTablesForTypicalHabtm < ActiveRecord::Migration
  def self.up
    create_table :magazines do |t|
      t.column :title, :string 
    end                      
    create_table :readers do |t|
      t.column :name, :string
    end                      
    create_table :magazines_readers, :id => false do |t|
      t.column :magazine_id, :integer
      t.column :reader_id, :integer
    end
  end

  def self.down
    drop_table :magazines
    drop_table :readers
    drop_table :magazines_readers    
  end
end
