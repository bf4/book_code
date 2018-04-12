#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeToken

  attr_accessor :credit_card_number, :expiration_month, :expiration_year, :cvc

  def initialize(credit_card_number:, expiration_month:, expiration_year:, cvc:)
    @credit_card_number = credit_card_number
    @expiration_month = expiration_month
    @expiration_year = expiration_year
    @cvc = cvc
  end

  def token
    @token ||= Stripe::Token.create(
        card: {
            number: credit_card_number, exp_month: expiration_month,
            exp_year: expiration_year, cvc: cvc})
  end

  delegate :id, to: :token

end
