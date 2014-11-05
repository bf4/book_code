#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street_address1
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
