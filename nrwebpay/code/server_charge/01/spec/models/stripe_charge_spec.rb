#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe StripeCharge, :vcr do

  let(:token) { StripeToken.new(
      credit_card_number: "4242424242424242", expiration_month: "12",
      expiration_year: Time.zone.now.year + 1, cvc: "123") }
  let(:payment) { build_stubbed(
      :payment, price: Money.new(3000), reference: Payment.generate_reference) }

  it "calls stripe to get a charge" do
    charge = StripeCharge.charge(token: token, payment: payment)
    expect(charge.id).to start_with("ch")
    expect(charge.amount).to eq(3000)
  end
end
