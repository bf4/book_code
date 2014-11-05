#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :fax_number
      t.integer :price, :default => 2
      t.integer :ratings_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
