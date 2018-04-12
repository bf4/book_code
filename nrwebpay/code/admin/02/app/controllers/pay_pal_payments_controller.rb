#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PayPalPaymentsController < ApplicationController

  def approved
    workflow = ExecutesPayPalPayment.new(
        payment_id: params[:paymentId],
        token: params[:token],
        payer_id: params[:PayerID])
    workflow.run
    redirect_to payment_path(id: workflow.payment.reference)
  end

end
