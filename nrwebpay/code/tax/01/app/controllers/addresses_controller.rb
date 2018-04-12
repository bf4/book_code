#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class AddressesController < ApplicationController

  def new
    @address = Address.new
  end

  def create
    workflow = AddsShippingToCart.new(
        user: current_user, address: params[:address].permit!,
        method: params[:shipping_method])
    workflow.run
    if workflow.success?
      redirect_to shopping_cart_path
    else
      render :new
    end
  end

end
