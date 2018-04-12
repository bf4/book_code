#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeRefund

  attr_accessor :payment_to_refund, :response, :error, :amount_to_refund

  def initialize(payment_to_refund:, amount_to_refund: nil)
    @payment_to_refund = payment_to_refund
    @amount_to_refund = amount_to_refund || -payment_to_refund.price_cents
  end

  delegate :original_payment, to: :payment_to_refund

  def refund
    return if original_payment.nil?
    @response = Stripe::Refund.create(
        {charge: original_payment.response_id, amount: amount_to_refund,
         metadata: {
             refund_reference: payment_to_refund.reference,
             original_reference: original_payment.reference}},
        idempotency_key: payment_to_refund.reference)
  rescue Stripe::CardError => e
    @response = nil
    @error = e
  end

  def success?
    response || !error
  end

  def refund_attributes
    success? ? success_attributes : failure_attributes
  end

  def success_attributes
    {status: :refunded,
     response_id: response.id, full_response: response.to_json}
  end

  def failure_attributes
    {status: :failed, full_response: error.to_json}
  end

end
