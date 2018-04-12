#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class ExecutesStripePurchaseJob < ActiveJob::Base

  queue_as :default

  rescue_from(PreExistingPaymentException) do |exception|
    Rollbar.error(exception)
  end

  def perform(payment, stripe_token)
    charge_action = ExecutesStripePurchase.new(payment, stripe_token)
    charge_action.run
  end

end
