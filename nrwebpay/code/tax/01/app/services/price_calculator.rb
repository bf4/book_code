#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PriceCalculator

  attr_accessor :tickets, :discount_code, :shipping

  def initialize(tickets = [], discount_code = nil, shipping = :none)
    @tickets = tickets
    @discount_code = discount_code || NullDiscountCode.new
    @shipping = shipping
  end

  def processing_fee
    (subtotal - discount).positive? ? Money.new(100) : Money.zero
  end

  def shipping_fee
    case shipping.to_sym
    when :standard then Money.new(200)
    when :overnight then Money.new(1000)
    else
      Money.zero
    end
  end

  def subtotal
    tickets.map(&:price).sum
  end

  def breakdown
    result = {ticket_cents: tickets.map { |t| t.price.cents }}
    if processing_fee.nonzero?
      result[:processing_fee_cents] = processing_fee.cents
    end
    result[:discount_cents] = -discount.cents if discount.nonzero?
    result[:shipping_cents] = shipping_fee.cents if shipping_fee.nonzero?
    result
  end

  def total_price
    subtotal - discount + processing_fee + shipping_fee
  end

  def discount
    discount_code.discount_for(subtotal)
  end

end
