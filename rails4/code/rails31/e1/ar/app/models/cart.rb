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
# Table name: carts
#
#  id         :integer         not null, primary key
#  created_at :datetime        
#  updated_at :datetime        
#

class Cart < ActiveRecord::Base
  has_many :line_items

  def add_product(product)
    current_item = line_items.find_by_product_id(product)
    if current_item
      current_item.increment_quantity
    else
      current_item = LineItem.create(:product=>product)
      line_items << current_item
    end
    current_item
  end


  def total_price
    @line_items.to_a.sum { |item| item.total_price }
  end

  def total_items
    @line_items.sum(:quantity)
  end
end
