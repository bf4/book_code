#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PurchasesCart

  attr_accessor :user, :purchase_amount_cents,
      :purchase_amount, :success,
      :payment

  def initialize(user: nil, purchase_amount_cents: nil)
    @user = user
    @purchase_amount = Money.new(purchase_amount_cents)
    @success = false
  end

  def run
    Payment.transaction do
      update_tickets
      create_payment
      purchase
      calculate_success
    end
  end

  def calculate_success
    @success = payment.succeeded?
  end

  def tickets
    @tickets ||= @user.tickets_in_cart
  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = Payment.create!(payment_attributes)
    payment.create_line_items(tickets)
  end

  def payment_attributes
    {user_id: user.id, price_cents: purchase_amount.cents,
     status: "created", reference: Payment.generate_reference}
  end

  def success?
    success
  end

end
