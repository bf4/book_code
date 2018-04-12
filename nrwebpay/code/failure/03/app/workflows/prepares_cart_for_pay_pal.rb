#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PreparesCartForPayPal < PreparesCart

  attr_accessor :pay_pal_payment

  def update_tickets
    tickets.each(&:pending!)
  end

  def redirect_on_success_url
    pay_pal_payment.redirect_url
  end

  def payment_attributes
    super.merge(payment_method: "paypal")
  end

  def calculate_success
    @success = payment.pending?
  end

  def on_success
    @pay_pal_payment = PayPalPayment.new(payment: payment)
    payment.update!(response_id: pay_pal_payment.response_id)
    payment.pending!
    reverse_purchase if payment.failed?
  end

end
