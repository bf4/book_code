#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeToken

  attr_accessor :credit_card_number, :expiration_month,
      :expiration_year, :cvc,
      :stripe_token

  def initialize(credit_card_number: nil, expiration_month: nil,
      expiration_year: nil, cvc: nil,
      stripe_token: nil)
    @credit_card_number = credit_card_number
    @expiration_month = expiration_month
    @expiration_year = expiration_year
    @cvc = cvc
    @stripe_token = stripe_token
  end

  def token
    @token ||= (stripe_token ? retrieve_token : create_token)
  end

  def id
    stripe_token || token.id
  end

  private def retrieve_token
    Stripe::Token.retrieve(stripe_token)
  end

  private def create_token
    Stripe::Token.create(
        card: {number: credit_card_number, exp_month: expiration_month,
               exp_year: expiration_year, cvc: cvc})
  end

  def to_s
    "STRIPE TOKEN: #{id}"
  end

  def inspect
    "STRIPE TOKEN #{id}"
  end

end
