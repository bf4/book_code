#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PriceCalculator

  attr_accessor :tickets, :discount_code, :shipping, :user, :address, :tax_id

  def initialize(tickets = [], discount_code = nil, shipping = :none,
      user: nil, address: nil, tax_id: nil)
    @tickets = tickets
    @discount_code = discount_code || NullDiscountCode.new
    @shipping = shipping
    @user = user
    @address = address
    @tax_id = tax_id
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
    result[:sales_tax] = tax_calculator.itemized_taxes if sales_tax.nonzero?
    result
  end

  def tax_calculator
    @tax_calculator ||= TaxCalculator.new(
        user: user, cart_id: tax_id, address: address, items: tax_items)
  end

  def sales_tax
    return Money.zero if address.nil?
    tax_calculator.tax_amount
  end

  def tax_items
    items = [TaxCalculator::Item.create(:ticket, 1, subtotal - discount)]
    if processing_fee.nonzero?
      items << TaxCalculator::Item.create(:processing, 1, processing_fee)
    end
    if shipping_fee.nonzero?
      items << TaxCalculator::Item.create(:shipping, 1, shipping_fee)
    end
    items
  end

  def total_price
    base_price + processing_fee + shipping_fee + sales_tax
  end

  def base_price
    subtotal - discount
  end

  def discount
    discount_code.discount_for(subtotal)
  end

  def affiliate_payment
    base_price * 0.05
  end

  def affiliate_application_fee
    total_price - affiliate_payment
  end


end
