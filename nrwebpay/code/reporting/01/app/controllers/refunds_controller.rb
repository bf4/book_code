#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class RefundsController < ApplicationController

  def create
    load_refundable
    authorize(@refundable, :refund?)
    workflow = PreparesStripeRefund.new(
        refundable: @refundable,
        administrator: current_user,
        refund_amount_cents: @refundable.price_cents)
    workflow.run
    flash[:alert] = workflow.error || "Refund submitted"
    redirect_to redirect_path
  end

  VALID_REFUNDABLES = %w(Payment PaymentLineItem).freeze

  private def load_refundable
    raise "bad refundable class" unless params[:type].in?(VALID_REFUNDABLES)
    @refundable = params[:type].constantize.find(params[:id])
  end

  private def redirect_path
    params[:type] == if params[:type] == "Payment"
                     then admin_payments_path
                     else admin_payments_line_item_path
                     end
  end

end
