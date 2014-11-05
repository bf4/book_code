#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateWombats < ActiveRecord::Migration
  def self.up
    create_table :wombats do |t|
      t.string :name
      t.text :bio
      t.integer :age

      t.timestamps
    end
  end

  def self.down
    drop_table :wombats
  end
end
