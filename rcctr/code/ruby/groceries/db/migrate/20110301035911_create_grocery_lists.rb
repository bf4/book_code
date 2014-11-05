#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
class CreateGroceryLists < ActiveRecord::Migration
  def self.up
    create_table :grocery_lists do |t|
      t.string :name
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :grocery_lists
  end
end
