#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe ExecutesPayPalPayment, :vcr, :aggregate_failures do

  describe "successful credit card purchase" do
    let!(:ticket_1) { instance_spy(
        Ticket, status: "pending", price: Money.new(1500), id: 1) }
    let!(:ticket_2) { instance_spy(
        Ticket, status: "pending", price: Money.new(1500), id: 2) }
    let!(:ticket_3) { instance_spy(Ticket, status: "unsold", id: 3) }
    let(:payment) { instance_spy(Payment, tickets: [ticket_1, ticket_2]) }
    let(:pay_pal_payment) { instance_spy(PayPalPayment, execute: true) }
    let(:user) { instance_double(
        User, id: 5, tickets_in_cart: [ticket_1, ticket_2]) }
    let(:workflow) { ExecutesPayPalPayment.new(
        payment_id: "PAYMENTID", token: "TOKEN", payer_id: "PAYER_ID") }

    before(:example) do
      allow(workflow).to receive(:payment).and_return(payment)
      allow(workflow).to receive(:pay_pal_payment).and_return(pay_pal_payment)
      workflow.run
    end

    it "updates the ticket status" do
      expect(ticket_1).to have_received(:purchased!)
      expect(ticket_2).to have_received(:purchased!)
      expect(ticket_3).not_to have_received(:purchased!)
      expect(payment).to have_received(:succeeded!)
      expect(pay_pal_payment).to have_received(:execute)
      expect(workflow.success).to be_truthy
    end

  end

end
