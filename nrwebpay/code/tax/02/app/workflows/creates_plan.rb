#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreatesPlan

  attr_accessor :remote_id, :name,
      :price_cents, :interval,
      :tickets_allowed, :ticket_category,
      :plan

  def initialize(remote_id:, name:,
      price_cents:, interval:,
      tickets_allowed:, ticket_category:)
    @remote_id = remote_id
    @name = name
    @price_cents = price_cents
    @interval = interval
    @tickets_allowed = tickets_allowed
    @ticket_category = ticket_category
  end

  def run
    remote_plan = Stripe::Plan.create(
        id: remote_id, amount: price_cents,
        currency: "usd", interval: interval,
        name: name)
    self.plan = Plan.create(
        remote_id: remote_plan.id, name: name,
        price_cents: price_cents, interval: interval,
        tickets_allowed: tickets_allowed, ticket_category: ticket_category,
        status: :active)
  end

end
