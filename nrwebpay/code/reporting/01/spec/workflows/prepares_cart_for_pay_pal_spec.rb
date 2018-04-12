#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe PreparesCartForPayPal, :vcr, :aggregate_failures do

  describe "successful credit card purchase" do
    let(:performance) { create(:performance, event: create(:event)) }
    let(:reference) { Payment.generate_reference }
    let(:ticket_1) { create(
        :ticket, status: "waiting",
                 price: Money.new(1500), performance: performance,
                 payment_reference: "reference") }
    let(:ticket_2) { create(
        :ticket, status: "waiting",
                 price: Money.new(1500), performance: performance,
                 payment_reference: "reference") }
    let(:ticket_3) { create(
        :ticket, status: "unsold",
                 performance: performance,
                 payment_reference: "reference") }
    let(:user) { create(:user) }
    let(:discount_code) { nil }
    let(:discount_code_string) { nil }
    let(:workflow) { PreparesCartForPayPal.new(
        user: user, purchase_amount_cents: 3000,
        expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}",
        payment_reference: "reference",
        discount_code_string: discount_code_string) }

    before(:example) do
      [ticket_1, ticket_2].each { |t| t.place_in_cart_for(user) }
    end

    it "updates the ticket status" do
      workflow.run
      [ticket_1, ticket_2, ticket_3].each(&:reload)
      expect(ticket_1).to be_pending
      expect(ticket_2).to be_pending
      expect(ticket_3).not_to be_pending
      expect(workflow.success).to be_truthy
      expect(workflow.payment).to have_attributes(
          user_id: user.id, price_cents: 3000,
          reference: a_truthy_value, payment_method: "paypal")
      expect(workflow.payment.payment_line_items.size).to eq(2)
      expect(workflow.redirect_on_success_url).to start_with(
          "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout")
      expect(workflow.payment.response_id).to eq(
          workflow.pay_pal_payment.pay_pal_payment.id)
    end

    context "with a discount code" do
      let!(:discount_code) { create(
          :discount_code, percentage: 25, code: "CODE") }
      let!(:discount_code_string) { "CODE" }
      let(:workflow) { PreparesCartForPayPal.new(
          user: user, purchase_amount_cents: 2250,
          expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}",
          payment_reference: "reference",
          discount_code_string: discount_code_string) }

      it "creates a transaction object" do
        workflow.run
        expect(workflow.payment).to have_attributes(
            user_id: user.id, price_cents: 2250, discount_cents: 750,
            reference: a_truthy_value, payment_method: "paypal")
        expect(workflow.payment.payment_line_items.size).to eq(2)
      end
    end

  end

end
