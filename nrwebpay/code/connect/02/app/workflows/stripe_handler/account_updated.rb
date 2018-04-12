#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
module StripeHandler

  class AccountUpdated

    attr_accessor :event, :success

    def initialize(event)
      @event = event
      @success = false
    end

    def account
      event.data.object
    end

    def affiliate
      Affiliate.find_by(stripe_id: account.id)
    end

    def run
      stripe_account = StripeAccount.new(affiliate, account: account)
      result = stripe_account.update_affiliate_verification
      @success = result
    end

  end

end
