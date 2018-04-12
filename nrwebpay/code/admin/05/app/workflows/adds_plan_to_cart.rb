#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class AddsPlanToCart

  attr_accessor :user, :plan, :result

  def initialize(user:, plan:)
    @user = user
    @plan = plan
    @result = nil
  end

  def run
    @result = Subscription.create!(
        user: user, plan: plan,
        start_date: Time.zone.now.to_date,
        end_date: plan.end_date_from,
        status: :waiting)
  end

  def success?
    result.valid?
  end

end
