#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# == Schema Information
# Schema version: 20100301000016
#
# Table name: orders
#
#  id             :integer         not null, primary key
#  name           :string(255)     
#  address        :text            
#  email          :string(255)     
#  pay_type       :string(10)      
#  created_at     :datetime        
#  updated_at     :datetime        
#  customer_email :string(255)     
#  placed_at      :datetime        default(2010-03-28 13:56:08 UTC)
#  attn           :string(100)     
#  order_type     :string(255)     
#  ship_class     :string(255)     default("priority"), not null
#  amount         :decimal(, )     
#  state          :string(2)       
#

class Order < ActiveRecord::Base
  PAYMENT_TYPES = [
    #  Displayed       stored in db
    [ "Check",          "check" ],
    [ "Credit card",    "cc" ],
    [ "Purchase order", "po" ]
  ]

  # ...
  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => 
    PAYMENT_TYPES.map {|disp, value| value}

  # ...


  has_many :line_items

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
