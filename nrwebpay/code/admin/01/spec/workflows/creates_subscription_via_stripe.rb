#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe CreatesSubscriptionViaStripe, :aggregate_failures, :vcr do

  describe "happy path", :vcr do

    let(:user) { create(User, id: 5) }
    let(:subscription) { Subscription.create!(
        user: user, plan: plan, status: :waiting) }
    let(:plan) { create(:plan,
        plan_name: "vip_monthly", remote_id: "vip_monthly") }
    let(:workflow) { StripeCreatesSubscription.new(
        user: user, expected_subscription_id: [subscription.id], token: token) }
    let(:token) { StripeToken.new(
        credit_card_number: "4242424242424242", expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }

    it "creates a customer" do
      workflow.run
      subscription.reload
      expect(subscription).to be_pending_initial_payment
      expect(user.stripe_id).to be_present
      expect(subscription.payment_method).to eq("stripe")
      expect(subscription.remote_id).to be_present
    end

  end

end
