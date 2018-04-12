#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class ExecutesPayPalPayment

  attr_accessor :payment_id, :token, :payer_id, :payment, :success

  def initialize(payment_id:, token:, payer_id:)
    @payment_id = payment_id
    @token = token
    @payer_id = payer_id
    @success = false
    @continue = true
  end

  def payment
    @payment ||= Payment.find_by(
        payment_method: "paypal", response_id: payment_id)
  end

  def pay_pal_payment
    @pay_pal_payment ||= PayPalPayment.find(payment_id)
  end

  def run
    Payment.transaction do
      pre_purchase
      purchase
      post_purchase
    end
  end

  def pre_purchase
    @continue = pay_pal_payment.valid?
  end

  def purchase
    return unless @continue
    @continue = pay_pal_payment.execute(payer_id: payer_id)
  end

  def post_purchase
    if @continue
      payment.tickets.each(&:purchased!)
      payment.succeeded!
      self.success = true
    else
      payment.tickets.each(&:waiting!)
      payment.failed!
    end
  end

end
