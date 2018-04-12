#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe PreparesStripeRefund, :vcr, :aggregate_failures do
  let(:ticket) { instance_spy(Ticket) }
  let(:payment) { instance_spy(Payment, id: 1) }
  let(:administrator) { instance_double(User, id: 5) }

  describe "preparation successful" do

    let(:workflow) { PreparesStripeRefund.new(
        administrator: administrator,
        refund_amount_cents: 3000, refundable: payment) }

    before(:example) {
      allow(payment).to receive(:tickets).and_return([ticket])
      allow(payment).to receive(:can_refund?).and_return(true)
    }

    it "is valid" do
      expect(workflow).to be_pre_purchase_valid
    end

    it "creates a shadow " do
      expect(RefundChargeJob).to receive(:perform_later)
          .with(refundable_id: payment.id)
      workflow.run
      expect(workflow).to be_a_success
      expect(payment).to have_received(:generate_refund_payment)
          .with(amount_cents: 3000, admin: administrator)
      expect(ticket).to have_received(:refund_pending!)
    end

  end

  describe "refunding a single line_item" do

    let(:item_to_refund) { instance_spy(
        PaymentLineItem, id: 1, buyable: ticket_to_refund,
                         payment: payment, tickets: [ticket_to_refund]) }
    let(:item_to_keep) { instance_spy(
        PaymentLineItem, id: 2, buyable: ticket_to_keep, payment: payment) }
    let(:ticket_to_refund) { instance_spy(Ticket) }
    let(:ticket_to_keep) { instance_spy(Ticket) }

    let(:workflow) { PreparesStripeRefund.new(
        administrator: administrator,
        refund_amount_cents: 3000, refundable: item_to_refund) }

    before(:example) do
      allow(Payment).to receive(:find).with(payment.id).and_return(payment)
      allow(payment).to receive(:can_refund?).and_return(true)
      allow(payment).to receive(:payment_line_items)
          .and_return([item_to_refund, item_to_keep])
    end

    it "creates a shadow " do
      expect(RefundChargeJob).to receive(:perform_later)
      workflow.run
      expect(workflow).to be_a_success
      expect(item_to_refund).to have_received(:generate_refund_payment)
          .with(amount_cents: 3000, admin: administrator)
      expect(ticket_to_refund).to have_received(:refund_pending!)
    end

  end

  describe "does not create a job if the payment does not exist" do

    let(:workflow) { PreparesStripeRefund.new(
        administrator: administrator,
        refund_amount_cents: 3000, refundable: nil) }

    it "creates a shadow " do
      expect(RefundChargeJob).not_to receive(:perform_later)
      workflow.run
      expect(workflow).not_to be_a_success
      expect(workflow).not_to receive(:generate_refund_payment)
      expect(ticket).not_to have_received(:status=)
    end

  end

  describe "does not create a job if the refund is too large" do
    let(:workflow) { PreparesStripeRefund.new(
        administrator: administrator,
        refund_amount_cents: 4000, refundable: payment) }

    it "creates a shadow " do
      expect(payment).to receive(:can_refund?).with(4000).and_return(false)
      expect(RefundChargeJob).not_to receive(:perform_later)
      workflow.run
      expect(workflow).not_to be_a_success
      expect(workflow).not_to receive(:generate_refund_payment)
      expect(ticket).not_to have_received(:status=)
    end
  end

  # not admin user

end
