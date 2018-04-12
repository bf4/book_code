#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PreparesCartForStripe < PreparesCart

  attr_accessor :stripe_token, :stripe_charge

  def initialize(user:, stripe_token:, purchase_amount_cents:,
      expected_ticket_ids:, payment_reference: nil)
    super(user: user, purchase_amount_cents: purchase_amount_cents,
          expected_ticket_ids: expected_ticket_ids,
          payment_reference: payment_reference)
    @stripe_token = stripe_token
  end

  def update_tickets
    tickets.each(&:purchased!)
  end

  def on_success
    ExecutesStripePurchaseJob.perform_later(payment, stripe_token.id)
  end

  def on_failure
    unpurchase_tickets
  end

  def unpurchase_tickets
    tickets.each(&:waiting!)
  end

  def purchase_attributes
    super.merge(payment_method: "stripe")
  end

end
