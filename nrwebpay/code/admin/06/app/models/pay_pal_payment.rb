#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PayPalPayment

  attr_accessor :payment, :pay_pal_payment

  delegate :create, to: :pay_pal_payment
  delegate :execute, to: :pay_pal_payment

  def self.find(payment_id)
    result = PayPalPayment.new(payment: payment)
    result.pay_pal_payment = PayPal::SDK::REST::Payment.find(payment_id)
    result
  end

  def initialize(payment:)
    @payment = payment
    @pay_pal_payment = build_pay_pal_payment
  end

  def build_pay_pal_payment
    PayPal::SDK::REST::Payment.new(
        intent: "sale", payer: {payment_method: "paypal"},
        redirect_urls: redirect_info, transactions: [payment_info])
  end

  def host_name
    Rails.application.secrets.host_name
  end

  def redirect_info
    {return_url: "http://#{host_name}/paypal/approved",
     cancel_url: "http://#{host_name}/paypal/rejected"}
  end

  def payment_info
    {item_list: {items: build_item_list},
     amount: {total: payment.price.format(symbol: false), currency: "USD"}}
  end

  def build_item_list
    payment.payment_line_items.map do |payment_line_item|
      {name: payment_line_item.name, sku: payment_line_item.event_id,
       price: payment_line_item.price.format(symbol: false), currency: "USD",
       quantity: 1}
    end
  end

  def created?
    pay_pal_payment.state == "created"
  end

  def redirect_url
    create unless created?
    pay_pal_payment.links.find { |link| link.method == "REDIRECT" }.href
  end

  def response_id
    create unless created?
    pay_pal_payment.id
  end

  def pay_pal_transaction
    pay_pal_payment.transactions.first
  end

  def pay_pal_amount
    Money.new(pay_pal_transaction.amount.total.to_f * 100)
  end

  def price_valid?
    pay_pal_amount == payment.price
  end

  def pay_pal_ticket_ids
    line_item_ids = pay_pal_transaction.items.map(&:name).map(&:to_i)
    line_items = line_item_ids.map { |id| PurchaseLineItem.find(id) }
    line_items.flat_map(&:tickets).map(&:id).sort
  end

  def item_valid?
    payment.sorted_ticket_ids == pay_pal_ticket_ids
  end

  def valid?
    price_valid? && item_valid?
  end

end
