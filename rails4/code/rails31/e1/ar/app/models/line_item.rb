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
# Table name: line_items
#
#  id         :integer         not null, primary key
#  product_id :integer         
#  cart_id    :integer         
#  created_at :datetime        
#  updated_at :datetime        
#  quantity   :integer         default(1)
#  order_id   :integer         
#

class LineItem < ActiveRecord::Base
  belongs_to :order, :touch => true


  belongs_to :product
  belongs_to :cart, :touch => true

  def title
    product.title
  end



  def increment_quantity
    self.quantity += 1
    touch
  end

  def total_price
    product.price * quantity
  end
end
