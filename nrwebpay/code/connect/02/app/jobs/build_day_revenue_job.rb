#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class BuildDayRevenueJob < ApplicationJob

  queue_as :default

  def perform(*_args)
    DayRevenue.transaction do
      DayRevenue.destroy_all
      ActiveRecord::Base.connection.select_all(
          %{SELECT date(created_at) as day,
          sum(price_cents) as price_cents,
          sum(discount_cents) as discounts_cents
          FROM "payments"
          WHERE "payments"."status" = 1
          GROUP BY date(created_at)
          HAVING date(created_at) < '#{1.day.ago.to_date}'}).map do |data|
        DayRevenue.create(data)
      end
      DayRevenue.all.each do |day_revenue|
        tickets = PaymentLineItem.tickets.no_refund
            .where("date(created_at) = ?", day_revenue.day).count
        day_revenue.update(ticket_count: tickets)
      end
    end
  end

end
