#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :username
      t.string :name
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
