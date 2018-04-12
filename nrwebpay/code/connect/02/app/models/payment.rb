#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class Payment < ActiveRecord::Base

  has_paper_trail

  include HasReference

  belongs_to :user, optional: true
  has_many :payment_line_items
  has_many :tickets, through: :payment_line_items,
                     source_type: "Ticket", source: "buyable"
  belongs_to :administrator, class_name: "User"
  has_many :refunds, class_name: "Payment",
                     foreign_key: "original_payment_id"
  belongs_to :original_payment, class_name: "Payment"
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :discount_code
  belongs_to :affiliate

  monetize :price_cents
  monetize :discount_cents
  monetize :affiliate_payment_cents

  enum status: {created: 0, succeeded: 1, pending: 2, failed: 3,
                refund_pending: 4, refunded: 5}

  enum shipping_method: {electronic: 0, standard: 1, overnight: 2}

  def total_cost
    tickets.map(&:price).sum
  end

  def create_line_items(tickets)
    tickets.each do |ticket|
      payment_line_items.create!(
          buyable: ticket, price_cents: ticket.price.cents)
    end
  end

  def sorted_ticket_ids
    tickets.map(&:id).sort
  end

  def generate_refund_payment(amount_cents:, admin:)
    refund_payment = Payment.create!(
        user_id: user_id, price_cents: -amount_cents, status: "refund_pending",
        payment_method: payment_method, original_payment_id: id,
        administrator: admin, reference: Payment.generate_reference)
    payment_line_items.each do |line_item|
      line_item.generate_refund_payment(
          admin: admin,
          amount_cents: amount_cents,
          refund_payment: refund_payment)
    end
    refund_payment
  end

  def payment
    self
  end

  def maximum_available_refund
    price + refunds.map(&:price).sum
  end

  def can_refund?(price)
    price <= maximum_available_refund
  end

  def refund?
    price.negative?
  end

  def date
    created_at.to_date
  end

  def full_value
    price + discount
  end

  def price_calculator
    @price_calculator ||= PriceCalculator.new(
        tickets, discount_code, shipping_method,
        address: shipping_address, user: user,
        tax_id: "payment_#{reference}")
  end

  def taxes_paid
    partials.fetch(:sales_tax, {}).values.sum
  end

  def application_fee
    return Money.zero if affiliate.blank?
    price - affiliate_payment
  end

  def active_affiliate
    affiliate&.stripe_charges_enabled ? affiliate : nil
  end

end
