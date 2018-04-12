#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe StripeToken, :vcr do

  it "calls stripe to get a token" do
    token = StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123")
    expect(token.id).to start_with("tok_")
  end

  it "works if it is given a token id" do
    token = StripeToken.new(stripe_token: "tok_something")
    expect(token.id).to eq("tok_something")
  end

  it "allows you to retrieve the token if given a token id" do
    original_token = StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123")
    new_token = StripeToken.new(stripe_token: original_token.id)
    expect(new_token.token.object).to eq(original_token.token.object)
  end

end
