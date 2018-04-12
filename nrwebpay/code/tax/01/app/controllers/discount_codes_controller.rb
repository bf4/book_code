#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class DiscountCodesController < ApplicationController

  def create
    workflow = AddsDiscountCodeToCart.new(
        user: current_user, code: params[:discount_code])
    workflow.run
    redirect_to shopping_cart_path
  end

end
