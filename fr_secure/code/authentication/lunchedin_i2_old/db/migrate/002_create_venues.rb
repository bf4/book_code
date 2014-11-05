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
      t.column :name, :string, :default => nil, :null => false
      t.column :address_one, :string, :default => nil
      t.column :address_two, :string, :default => nil
      t.column :city, :string, :default => nil
      t.column :state, :string, :default => nil
      t.column :zip_code, :string, :default => nil      
      t.column :phone_number, :string, :default => nil
      t.column :fax_number, :string, :default => nil
      t.column :price, :integer, :default => 2
      t.column :ratings_count, :integer, :default => 0
    end
  end

  def self.down
    drop_table :venues
  end
end
