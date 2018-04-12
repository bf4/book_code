#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class DailyRevenue

  include Reportable

  attr_accessor :date, :revenue, :discounts

  def self.find_collection
    ActiveRecord::Base.connection.select_all(
        %{SELECT date(created_at) as date,
        sum(price_cents) as price_cents,
        sum(discount_cents) as discount_cents
        FROM "payments"
        WHERE "payments"."status" = 1
        GROUP BY date(created_at)}).map do |data|
      DailyRevenue.new(**data.symbolize_keys)
    end
  end

  def initialize(date:, price_cents:, discount_cents:)
    @date = date
    @revenue = price_cents.to_money
    @discounts = discount_cents.to_money
  end

  columns do
    column(:date)
    column(:revenue)
    column(:discounts)
    column(:ticket_count)
  end

  def ticket_count
    PaymentLineItem.tickets.no_refund
        .where("date(created_at) = ?", date).count
  end

end
