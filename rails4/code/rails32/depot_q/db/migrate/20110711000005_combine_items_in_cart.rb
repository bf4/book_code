#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class CombineItemsInCart < ActiveRecord::Migration

  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(product_id: product_id).delete_all

          # replace with a single item
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do 
        LineItem.create cart_id: line_item.cart_id,
          product_id: line_item.product_id
      end

      # remove original item
      line_item.destroy
    end
  end
end
