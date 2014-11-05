#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ProductsController < ApplicationController
  
  def index
    conditions = params[:search].blank? ? nil : ['name like ? or description like ?', "%#{params[:search]}%", "%#{params[:search]}%"]
    @pages, @products = paginate :products, :conditions => conditions
  end
  
  def show
    @product = Product.find params[:id]
  end
  
end
