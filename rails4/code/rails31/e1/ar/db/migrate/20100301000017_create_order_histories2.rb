#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class CreateOrderHistories2 < ActiveRecord::Migration

  class Order < ActiveRecord::Base; end
  class OrderHistory < ActiveRecord::Base; end

  def self.up
    create_table :order_histories do |t|
      t.integer :order_id, :null => false
      t.text :notes
  
      t.timestamps
    end
  
    order = Order.find :first
    OrderHistory.create(:order_id => order, :notes => "test")
  end
  
  def self.down
    drop_table :order_histories
  end
end
