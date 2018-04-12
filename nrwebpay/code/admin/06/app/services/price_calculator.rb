#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PriceCalculator

  attr_accessor :tickets, :discount_code

  def initialize(tickets = [], discount_code = nil)
    @tickets = tickets
    @discount_code = discount_code || NullDiscountCode.new
  end

  def subtotal
    tickets.map(&:price).sum
  end

  def total_price
    discount_code.apply_to(subtotal)
  end

  def discount
    discount_code.discount_for(subtotal)
  end

end
