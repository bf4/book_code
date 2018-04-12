#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeCustomer

  attr_accessor :user

  delegate :subscriptions, :id, to: :remote_customer

  def initialize(user: nil)
    @user = user
  end

  def remote_customer
    @remote_customer ||= begin
      if user.stripe_id
        Stripe::Customer.retrieve(user.stripe_id)
      else
        Stripe::Customer.create(email: user.email).tap do |remote_customer|
          user.update!(stripe_id: remote_customer.id)
        end
      end
    end
  end

  def valid?
    remote_customer.present?
  end

  def find_subscription_for(plan)
    subscriptions.find { |s| s.plan.id == plan.remote_id }
  end

  def add_subscription(subscription)
    remote_subscription = remote_customer.subscriptions.create(
        plan: subscription.remote_plan_id)
    subscription.update!(remote_id: remote_subscription.id)
  end

  def source=(token)
    remote_customer.source = token.id
    remote_customer.save
  end

end
