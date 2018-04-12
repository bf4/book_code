#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CashPurchasesCart < PreparesCart

  def update_tickets
    tickets.each(&:purchased!)
  end

  def on_success
    @success = true
  end

  def payment_attributes
    super.merge(
        payment_method: "cash", status: "succeeded",
        administrator_id: user.id)
  end

  def pre_purchase_valid?
    raise UnauthorizedPurchaseException.new(user: user) unless user.admin?
    true
  end

  def on_failure
    unpurchase_tickets
  end

end
