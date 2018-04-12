#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class UpdatesAffiliateAccount

  attr_accessor :affiliate, :user, :params, :success

  def initialize(affiliate:, user:, params:)
    @affiliate = affiliate
    @user = user
    @params = params
    @success = false
  end

  def affiliate_belongs_to_user?
    return true unless affiliate
    return true unless user
    affiliate&.user == user
  end

  def stripe_account
    @stripe_account ||= StripeAccount.new(affiliate)
  end

  def run
    Affiliate.transaction do
      return if user.nil? || affiliate.nil?
      return unless affiliate_belongs_to_user?
      stripe_account.update(params)
      @success = true
    end
  end

  def success?
    @success
  end

end
