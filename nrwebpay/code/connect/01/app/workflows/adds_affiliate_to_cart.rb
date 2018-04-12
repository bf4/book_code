#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class AddsAffiliateToCart

  attr_accessor :user, :tag

  def initialize(user:, tag:)
    @user = user
    @tag = tag&.downcase
  end

  def affiliate
    return nil if tag.blank?
    @affiliate ||= Affiliate.find_by(tag: tag)
  end

  def shopping_cart
    @shopping_cart ||= ShoppingCart.for(user: user)
  end

  def affiliate_belongs_to_user?
    return true unless affiliate
    return true unless user
    affiliate&.user == user
  end

  def run
    return unless user
    return if affiliate_belongs_to_user?
    shopping_cart.update(affiliate: affiliate)
  end

end
