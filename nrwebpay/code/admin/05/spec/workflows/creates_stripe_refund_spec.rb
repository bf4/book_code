#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe CreatesStripeRefund, :vcr, :aggregate_failures do

  let(:user) { create(:user) }
  let(:administrator) { create(:user) }
  let(:token) { StripeToken.new(
      credit_card_number: "4242424242424242", expiration_month: "12",
      expiration_year: Time.zone.now.year + 1, cvc: "123") }
  let(:payment) { Payment.create(
      user_id: user.id, price_cents: 2500, status: "refund_pending",
      reference: Payment.generate_reference, payment_method: "stripe") }
  let!(:payment_line_item) { PaymentLineItem.create(
      payment_id: payment.id, buyable: ticket,
      price_cents: 1500, refund_status: "no_refund") }
  let(:performance) { create(:performance) }
  let(:ticket) { create(
      :ticket, performance: performance, status: "refund_pending") }
  let(:payment_action) { ExecutesStripePurchase.new(payment, token.id) }

  describe "happy path end-to-end ish test" do

    it "creates a refund" do
      expect(RefundMailer).to receive_message_chain(
          :notify_success, :deliver_later)
      expect(RefundMailer).to receive(:notify_failure).never
      payment_action.run
      refund_payment = payment.generate_refund_payment(
          amount_cents: 2500, admin: administrator)
      workflow = CreatesStripeRefund.new(payment_to_refund: refund_payment)
      workflow.run

      expect(refund_payment).to have_attributes(
          status: "refunded", response_id: a_string_starting_with("re_"),
          full_response: workflow.stripe_refund.response.to_json)
      payment.reload
      ticket.reload
      expect(payment).to be_refunded
      expect(ticket).to be_refunded
      expect(refund_payment.payment_line_items.map(&:refund_status))
          .to eq(["refunded"])
      expect(performance.tickets.unsold.count).to eq(1)
      expect(performance.tickets.map(&:status))
          .to match_array(%w(refunded unsold))
    end

  end

end
