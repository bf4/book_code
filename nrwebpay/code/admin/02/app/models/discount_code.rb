#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class DiscountCode < ApplicationRecord

  monetize :minimum_amount_cents
  monetize :maximum_discount_cents

  def percentage_float
    percentage * 1.0 / 100
  end

  def multiplier
    1 - percentage_float
  end

  def apply_to(subtotal)
    subtotal - discount_for(subtotal)
  end

  def discount_for(subtotal)
    return Money.zero unless applies_to_total?(subtotal)
    result = subtotal * percentage_float
    result = [result, maximum_discount].min if maximum_discount?
    result
  end

  def maximum_discount?
    maximum_discount_cents.present? && maximum_discount > Money.zero
  end

  def applies_to_total?(subtotal)
    return true if minimum_amount_cents.nil?
    subtotal >= minimum_amount
  end

end
