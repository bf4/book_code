#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddTablesForUsersAndCarts < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string
      t.column :email, :string
    end
    create_table :carts do |t|
      t.column :user_id, :integer
    end
    create_table :carts_products, :id => false do |t|
      t.column :cart_id, :integer
      t.column :product_id, :integer
    end
  end

  def self.down
    drop_table :users
    drop_table :carts
    drop_table :carts_products
  end
end
