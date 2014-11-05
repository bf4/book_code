#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class OrderController < ApplicationController
  
  before_filter :authenticate, :only => 'checkout'
  before_filter :find_order_items
  
  def add
    product = Product.find(params[:id]) rescue nil
    quantity = params[:quantity].to_i
    if product && !quantity.zero?
      @order_items.each do |item|
        if item.product == product
          item.quantity += quantity
          flash[:notice] = "Product added to order".t
          return
        end
      end
      @order_items << OrderItem.new(:product_id => product.id, :quantity => quantity)
      flash[:notice] = "Added new product to order".t      
    else
      flash[:error] = "Could not add product to order".t
    end
    session[:order_items] = @order_items
  end

  def remove
    if @order_items.detect{|i| i.product_id == params[:id].to_i }
      session[:order_items] = @order_items = @order_items.reject{|i| i.product_id == params[:id].to_i }
      flash[:notice] = "Product removed from order".t
    else
      flash[:error] = "Could not remove product from order".t
    end
    redirect_to :action => 'index'
  end

  def checkout
    
  end
  
  #######
  private
  #######
  
  def find_order_items
    @order_items = session[:order_items]
    @order_items ||= []
  end
  
end
