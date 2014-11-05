#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateOrdersTables < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :customer_id, :integer
      t.column :created_at, :datetime
    end
    create_table :order_items do |t|
      t.column :order_id, :integer
      t.column :product_id, :integer
      t.column :quantity, :integer
    end
  end

  def self.down
    drop_table :orders
    drop_table :order_items
  end
end
