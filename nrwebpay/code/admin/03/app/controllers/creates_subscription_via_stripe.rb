#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreatesSubscriptionViaStripe

  attr_accessor :user, :expected_subscription_id, :token, :success

  def initialize(user:, expected_subscription_id:, token:)
    @user = user
    @expected_subscription_id = expected_subscription_id
    @token = token
    @successs = false
  end

  def subscription
    @subscription ||= user.subscriptions_in_cart.first
  end

  def expected_plan_valid?
    expected_subscription_id.first.to_i == subscription.id.to_i
  end

  def run
    Payment.transaction do
      return unless expected_plan_valid?
      stripe_customer = StripeCustomer.new(user: user)
      return unless stripe_customer.valid?
      stripe_customer.source = token
      subscription.make_stripe_payment(stripe_customer)
      stripe_customer.add_subscription(subscription)
      @success = true
    end
  rescue Stripe::StripeError => exception
    Rollbar.error(exception)
  end

  def redirect_on_success_url
    user
  end

end
