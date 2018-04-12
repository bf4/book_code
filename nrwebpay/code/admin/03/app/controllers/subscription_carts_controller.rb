#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class SubscriptionCartsController < ApplicationController

  #
  def show
    @cart = SubscriptionCart.new(current_user)
  end
  #

  #
  def update
    plan = Plan.find(params[:plan_id])
    workflow = AddsPlanToCart.new(user: current_user, plan: plan)
    workflow.run
    if workflow.result
      redirect_to subscription_cart_path
    else
      redirect_to plans_path
    end
  end
  #

end
