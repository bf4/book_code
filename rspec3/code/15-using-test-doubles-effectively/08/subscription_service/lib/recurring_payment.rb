#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'cash_cow'

class RecurringPayment
  def self.process_subscriptions(subscriptions)
    cards_and_amounts = subscriptions.each_with_object({}) do |sub, data|
      data[sub.credit_card] = sub.amount
    end

    CashCow.bulk_charge_cards(cards_and_amounts)
    # ...send receipts and other stuff...
  end
end
