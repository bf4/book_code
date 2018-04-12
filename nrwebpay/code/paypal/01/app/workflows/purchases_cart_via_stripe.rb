#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PurchasesCartViaStripe < PurchasesCart

  attr_accessor :stripe_token, :stripe_charge

  def initialize(user:, stripe_token:, purchase_amount_cents:)
    super(user: user, purchase_amount_cents: purchase_amount_cents)
    @stripe_token = stripe_token
  end

  def update_tickets
    tickets.each(&:purchased!)
  end

  def purchase
    @stripe_charge = StripeCharge.charge(token: stripe_token, payment: payment)
    payment.update!(
        status: @stripe_charge.status, response_id: @stripe_charge.id,
        full_response: @stripe_charge.to_json)
  end

  def payment_attributes
    super.merge(payment_method: "stripe")
  end

end
