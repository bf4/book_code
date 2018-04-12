#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class AddsShippingToCart

  attr_accessor :user, :address_fields, :method

  def initialize(user:, address:, method:)
    @user = user
    @address_fields = address
    @method = method
    @success = false
  end

  def shopping_cart
    @shopping_cart ||= ShoppingCart.for(user: user)
  end

  def run
    ShoppingCart.transaction do
      shopping_cart.create_address!(address_fields)
      shopping_cart.update!(shipping_method: method)
      @success = shopping_cart.valid?
    end
  rescue ActiveRecord::RecordInvalid
    @success = false
  end

  def success?
    @success
  end

end
