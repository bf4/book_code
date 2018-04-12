#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class AddsDiscountCodeToCart

  attr_accessor :user, :code

  def initialize(user:, code:)
    @user = user
    @code = code
    @success = false
  end

  def shopping_cart
    @shopping_cart ||= ShoppingCart.for(user: user)
  end

  def discount_code
    @discount_code ||= DiscountCode.find_by(code: code)
  end

  def run
    @success = shopping_cart.update(discount_code: discount_code)
  end

  def success?
    @success
  end

end
