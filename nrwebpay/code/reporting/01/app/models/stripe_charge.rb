#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeCharge

  attr_accessor :token, :payment, :response, :error

  def self.charge(token:, payment:)
    StripeCharge.new(token: token, payment: payment).charge
  end

  def initialize(token:, payment:)
    @token = token
    @payment = payment
  end


  def charge
    return if response.present?
    @response = Stripe::Charge.create(
        {amount: payment.price.cents, currency: "usd",
         source: token.id, description: "",
         metadata: {reference: payment.reference}},
        idempotency_key: payment.reference)
  rescue Stripe::StripeError => e
    @response = nil
    @error = e
  end

  def success?
    response || !error
  end

  def payment_attributes
    success? ? success_attributes : failure_attributes
  end

  def success_attributes
    {status: :succeeded,
     response_id: response.id, full_response: response.to_json}
  end

  def failure_attributes
    {status: :failed, full_response: error.to_json}
  end

end
