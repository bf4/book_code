#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class NotifiesTaxCloud

  attr_accessor :payment

  def initialize(payment)
    @payment = payment
    @success = false
  end

  def tax_calculator
    @tax_calculator ||= purchase.price_calculator.tax_calculator
  end

  def valid_amount?
    tax_calculator.tax_amount == payment.paid_taxes
  end

  def run
    if valid_amount?
      result = tax_calculator.authorized_with_capture(payment.reference)
      @success = (result == "OK")
    else
      raise TaxValidityException.new(
          payment_id: payment.id, expected_taxes: tax_calculator.tax_amount,
          paid_taxes: payment.paid_taxes)
    end
  end

end
