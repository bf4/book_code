#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class FakePaymentProcessorController < ApplicationController
  def show
    sleep 2
    render json: {
      credit_card_info: {
        cardholder_id: params[:id],
        last_four: Faker::Business.credit_card_number[-4..-1],
        expiration_month: Faker::Business.credit_card_expiry_date.month,
        expiration_year: Faker::Business.credit_card_expiry_date.year,
        type: Faker::Business.credit_card_type,
        link: Faker::Internet.url,
      }
    }
  end
end
