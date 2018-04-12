#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe PurchasesCart do

  describe "successful credit card purchase", :vcr do
    let(:reference) { Payment.generate_reference }
    let(:ticket_1) { instance_spy(
        Ticket, status: "waiting", price: Money.new(1500), id: 1) }
    let(:ticket_2) { instance_spy(
        Ticket, status: "waiting", price: Money.new(1500), id: 2) }
    let(:ticket_3) { instance_spy(Ticket, status: "unsold", id: 3) }
    let(:user) { instance_double(
        User, id: 5, tickets_in_cart: [ticket_1, ticket_2]) }
    let(:token) { StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }
    let(:workflow) { PurchasesCart.new(
        user: user, purchase_amount_cents: 3000,
        stripe_token: token) }
    let(:attributes) { {user_id: user.id, price_cents: 3000,
                        reference: a_truthy_value, payment_method: "stripe",
                        status: "created"} }
    let(:payment) { instance_double(
        Payment, succeeded?: true, price: Money.new(3000),
                 reference: reference) }

    before(:example) do
      allow(Payment).to receive(:create!).with(attributes).and_return(payment)
      allow(payment).to receive(:update!).with(
          status: "succeeded", response_id: a_string_starting_with("ch_"),
          full_response: a_truthy_value)
      expect(payment).to receive(:create_line_items).with([ticket_1, ticket_2])
      workflow.run
    end

    it "updates the ticket status" do
      expect(ticket_1).to have_received(:purchased!)
      expect(ticket_2).to have_received(:purchased!)
      expect(ticket_3).not_to have_received(:purchased!)
      expect(workflow.payment_attributes).to match(attributes)
      expect(workflow.success).to be_truthy
    end

  end

end
