#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe ExecutesStripePurchase, :vcr, :aggregate_failures do
  let(:user) { create(:user) }
  let(:payment) { Payment.create(
      user_id: user.id, price_cents: 2500, status: "created",
      reference: Payment.generate_reference, payment_method: "stripe") }
  let(:workflow) { ExecutesStripePurchase.new(payment, token.id) }

  describe "successful credit card purchase" do
    let(:token) { StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }

    context "without an affiliate" do
      before(:example) do
        workflow.run
      end

      it "takes the response from the gateway" do
        expect(workflow.payment).to have_attributes(
            status: "succeeded", response_id: a_string_starting_with("ch_"),
            full_response: workflow.stripe_charge.response.to_json)
      end
    end

    context "with an affiliate fee" do
      let(:affiliate_user) { create(:user) }
      let(:affiliate_workflow) {
        AddsAffiliateAccount.new(user: affiliate_user) }
      let(:affiliate) { affiliate_workflow.affiliate }

      before(:example) do
        affiliate_workflow.run
        payment.update(
            affiliate_id: affiliate.id, affiliate_payment_cents: 125)
        workflow.run
      end

      it "takes the response from the gateway" do
        response = workflow.stripe_charge.response
        expect(workflow.payment).to have_attributes(
            status: "succeeded", response_id: a_string_starting_with("ch_"),
            full_response: response.to_json)
        fee = Stripe::ApplicationFee.retrieve(response.application_fee)
        expect(fee.amount).to eq(2375)
      end

    end

  end

  describe "an unsuccessful credit card purchase" do
    let(:token) { StripeToken.new(
        credit_card_number: "4000000000000002", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }

    before(:example) do
      expect(workflow).to receive(:unpurchase_tickets)
      workflow.run
    end

    it "takes the response from the gateway" do
      expect(workflow.payment).to have_attributes(
          status: "failed", response_id: nil,
          full_response: workflow.stripe_charge.error.to_json)
    end
  end

end
