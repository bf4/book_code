#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Payment, type: :model do

  describe "generate_reference" do

    before(:example) do
      allow(SecureRandom).to receive(:hex).and_return("first", "second")
    end

    it "generates a reference" do
      expect(Payment.generate_reference).to eq("first")
    end

    it "avoids duplicates" do
      create(:payment, reference: "first", user: create(:user))
      expect(Payment.generate_reference).to eq("second")
    end

  end

  describe "copy for refund" do
    let(:user) { create(:user) }
    let(:administrator) { create(:user) }
    let(:ticket) { create(:ticket) }
    let(:payment) { Payment.create(
        user_id: user.id, price_cents: 3000,
        reference: Payment.generate_reference, payment_method: "stripe") }
    let!(:payment_line_item) { PaymentLineItem.create(
        payment_id: payment.id, buyable: ticket,
        price_cents: 1500, refund_status: "no_refund") }

    it "creates a refund copy" do
      refund_payment = payment.generate_refund_payment(
          amount_cents: 3000, admin: administrator)
      refund_payment.save!
      expect(refund_payment).to have_attributes(
          user_id: user.id, price_cents: -3000,
          reference: a_truthy_value, payment_method: "stripe",
          administrator_id: administrator.id, original_payment_id: payment.id)
      expect(refund_payment).to be_refund_pending
      expect(payment.refunds).to eq([refund_payment])
      line_item = refund_payment.payment_line_items.first
      expect(line_item).to have_attributes(
          payment_id: refund_payment.id, buyable: ticket,
          price_cents: -1500, refund_status: "refund_pending",
          original_line_item_id: payment_line_item.id)
      expect(line_item.original_payment).to eq(payment)
    end

  end

  describe "maximum_available_refund" do
    let(:user) { create(:user) }
    let(:ticket_1) { create(:ticket) }
    let(:ticket_2) { create(:ticket) }
    let(:payment) { Payment.create(
        user_id: user.id, price_cents: 3000,
        reference: Payment.generate_reference, payment_method: "stripe") }
    let!(:payment_line_item_1) { PaymentLineItem.create(
        payment_id: payment.id, buyable: ticket_1,
        price_cents: 1500, refund_status: "no_refund") }
    let!(:payment_line_item_2) { PaymentLineItem.create(
        payment_id: payment.id, buyable: ticket_2,
        price_cents: 1500, refund_status: "no_refund") }

    it "calculates the maximum available refund when there are no refunds" do
      expect(payment.maximum_available_refund).to eq(Money.new(3000))
      expect(payment.can_refund?(Money.new(1500))).to be_truthy
    end

    it "calculates when there is a refund" do
      payment.generate_refund_payment(amount_cents: 3000, admin: user)
      expect(payment.maximum_available_refund).to eq(Money.new(0))
    end

    it "calculates when there is a partial refund" do
      payment_line_item_1.generate_refund_payment(
          amount_cents: 1500, admin: user)
      expect(payment.maximum_available_refund).to eq(Money.new(1500))
    end

  end

end
