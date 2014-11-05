#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateOrders < ActiveRecord::Migration
  class Order < ActiveRecord::Base; end
  def self.up
    create_table :orders do |t|
      t.column :created_at, :datetime
      t.column :purchaser, :string
      t.column :price, :float
    end
    Order.create(:purchaser => "Kilgore Trout", :price => 123.22)
    Order.create(:purchaser => "John Barth", :price => 44.12)    
    Order.create(:purchaser => "Josef K", :price => 42.44)        
  end

  def self.down
    drop_table :orders
  end
end
