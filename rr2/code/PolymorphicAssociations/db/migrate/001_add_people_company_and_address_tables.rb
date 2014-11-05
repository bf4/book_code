#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddPeopleCompanyAndAddressTables < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column :name, :string
    end
    create_table :companies do |t|
      t.column :name, :string
    end
    create_table :addresses do |t|
      t.column :street_address1, :string
      t.column :street_address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :country, :string
      t.column :postal_code, :string
      t.column :addressable_id, :integer
      t.column :addressable_type, :string
    end
  end

  def self.down
    drop_table :people
    drop_table :companies
    drop_table :addresses
  end
end
