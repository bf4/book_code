#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddUsersAndCarts < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
    end
    create_table :carts do |t|
      t.integer :user_id
    end
    create_table :selections do |t|
      t.integer :cart_id
      t.integer :product_id
    end
  end
  def self.down
  end
end
