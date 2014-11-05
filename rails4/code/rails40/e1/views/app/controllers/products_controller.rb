#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class ProductsController < ApplicationController

  def new
    @product = Product.new
    @details = Detail.new
  end
  
  def create
    @product = Product.new(params[:product])
    @details = Detail.new(params[:details])

    Product.transaction do
      @product.save!
      @details.product = @product
      @details.save!
      redirect_to :action => :show, :id => @product
    end

  rescue ActiveRecord::RecordInvalid => e
    @details.valid?   # force checking of errors even if products failed
    render :action => :new
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
