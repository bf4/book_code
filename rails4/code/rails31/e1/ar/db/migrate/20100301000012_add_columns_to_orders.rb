#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class AddColumnsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :attn, :string, :limit => 100
    add_column :orders, :order_type,  :integer
    add_column :orders, :ship_class, :string, :null => false, :default => 'priority'
    add_column :orders, :amount, :decimal, :precision => 8, :scale => 2
    add_column :orders, :state, :string, :limit => 2
  end

  def self.down
    remove_column :orders, :attn
    remove_column :orders, :age
    remove_column :orders, :ship_class
    remove_column :orders, :amount
    remove_column :orders, :state
  end
end
