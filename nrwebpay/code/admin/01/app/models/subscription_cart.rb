#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class SubscriptionCart

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def subscriptions
    @subscriptions ||= user.subscriptions_in_cart
  end

  def total_cost
    subscriptions.map(&:plan).map(&:price).sum
  end

  def item_ids
    subscriptions.map(&:id)
  end

  def item_attribute
    :subscription_ids
  end

end
