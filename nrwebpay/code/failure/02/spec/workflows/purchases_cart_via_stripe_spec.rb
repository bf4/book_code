#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe PurchasesCartViaStripe, :vcr, :aggregate_failures do

  let(:user) { instance_double(
      User, id: 5, tickets_in_cart: [ticket_1, ticket_2]) }
  let(:reference) { Payment.generate_reference }
  let(:ticket_1) { instance_spy(
      Ticket, status: "waiting",
              price: Money.new(1500), id: 1,
              payment_reference: "reference") }
  let(:ticket_2) { instance_spy(
      Ticket, status: "waiting",
              price: Money.new(1500), id: 2,
              payment_reference: "reference") }
  let(:ticket_3) { instance_spy(
      Ticket, status: "unsold",
              id: 3, payment_reference: "reference") }
  let(:workflow) { PurchasesCartViaStripe.new(
      user: user, purchase_amount_cents: 3000,
      stripe_token: token, expected_ticket_ids: "1 2",
      payment_reference: "reference") }
  let(:payment) { instance_double(
      Payment, succeeded?: true, price: Money.new(3000),
               reference: reference) }
  let(:attributes) {
    {user_id: user.id, price_cents: 3000,
     reference: a_truthy_value, status: "created"} }

  describe "successful credit card purchase" do
    let(:token) { StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }

    before(:example) do
      allow(Payment).to receive(:new).and_return(payment)
      allow(payment).to receive(:update!).with(attributes)
      allow(payment).to receive(:update!).with(
          status: "succeeded", response_id: a_string_starting_with("ch_"),
          full_response: a_truthy_value)
      expect(payment).to receive(:create_line_items).with([ticket_1, ticket_2])
      expect(payment).to receive(:failed?).and_return(false)
      expect(payment).to receive(:response_id).and_return(nil)
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

  describe "an unsuccessful credit card purchase" do
    let(:token) { StripeToken.new(
        credit_card_number: "4000000000000002", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }

    before(:example) do
      allow(Payment).to receive(:new).and_return(payment)
      allow(payment).to receive(:update!).with(attributes)
      allow(payment).to receive(:update!).with(
          status: :failed, full_response: a_truthy_value)
      expect(payment).to receive(:create_line_items).with([ticket_1, ticket_2])
      expect(payment).to receive(:failed?).and_return(true)
      expect(payment).to receive(:response_id).and_return(nil)
      workflow.run
    end

    it "updates the ticket status" do
      expect(ticket_1).to have_received(:purchased!)
      expect(ticket_2).to have_received(:purchased!)
      expect(ticket_3).not_to have_received(:purchased!)
      expect(ticket_1).to have_received(:waiting!)
      expect(ticket_2).to have_received(:waiting!)
      expect(ticket_3).not_to have_received(:waiting!)
    end

  end

  describe "pre-flight fails" do
    let(:token) { instance_spy(StripeToken) }

    describe "expected price" do
      let(:workflow) { PurchasesCartViaStripe.new(
          user: user, purchase_amount_cents: 2500, stripe_token: token,
          expected_ticket_ids: "1 2") }

      it "does not payment if the expected price is incorrect" do
        allow(payment).to receive(:save).and_return(true)
        workflow.run
        expect(workflow).not_to be_pre_purchase_valid
        expect(ticket_1).not_to have_received(:purchased!)
        expect(ticket_2).not_to have_received(:purchased!)
        expect(ticket_3).not_to have_received(:purchased!)
        expect(workflow.success).to be_falsy
        expect(workflow.payment).to be_nil
      end
    end

    describe "expected tickets" do
      let(:workflow) { PurchasesCartViaStripe.new(
          user: user, purchase_amount_cents: 3000, stripe_token: token,
          expected_ticket_ids: "1 3") }

      it "does not trigger payment if the expected tickets are incorrect" do
        workflow.run
        expect(workflow).not_to be_pre_purchase_valid
        expect(ticket_1).not_to have_received(:purchased!)
        expect(ticket_2).not_to have_received(:purchased!)
        expect(ticket_3).not_to have_received(:purchased!)
        expect(workflow.success).to be_falsy
        expect(workflow.payment).to be_nil
      end
    end

    describe "database failure" do
      it "does not trigger payment if the database fails" do
        expect(StripeCharge).to receive(:new).never
        allow(Payment).to receive(:create!).and_raise(
            ActiveRecord::RecordInvalid)
        expect { workflow.run }.to raise_error(
            ActiveRecord::ActiveRecordError)
      end
    end
  end
end
