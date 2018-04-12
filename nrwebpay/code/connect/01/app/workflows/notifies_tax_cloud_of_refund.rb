#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class NotifiesTaxCloudOfRefund

  attr_accessor :payment

  def initialize(payment)
    @payment = payment
    @success = false
  end

  def tax_calculator
    @tax_calculator ||= purchase.price_calculator.tax_calculator
  end

  def reference
    payment.original_payment&.reference || payment.reference
  end

  def run
    result = tax_calculator.refund(reference)
    @success = (result == "OK")
  end

end
