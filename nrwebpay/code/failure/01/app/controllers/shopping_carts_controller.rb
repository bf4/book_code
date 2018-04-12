#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class ShoppingCartsController < ApplicationController

  #
  def show
    @cart = ShoppingCart.new(current_user)
  end
  #

  #
  def update
    performance = Performance.find(params[:performance_id])
    workflow = AddsToCart.new(
        user: current_user, performance: performance,
        count: params[:ticket_count])
    workflow.run
    if workflow.success
      redirect_to shopping_cart_path
    else
      redirect_to performance.event
    end
  end
  #

end
