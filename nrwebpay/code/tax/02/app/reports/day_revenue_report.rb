#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class DayRevenueReport < SimpleDelegator

  include Reportable

  def self.find_collection
    result = DayRevenue.all.map { |dr| DayRevenueReport.new(dr) }
    result << DayRevenueReport.new(DayRevenue.build_for(Date.yesterday))
    result << DayRevenueReport.new(DayRevenue.build_for(Date.current))
    result.sort_by(&:day)
  end

  def initialize(day_revenue)
    super(day_revenue)
  end

  columns do
    column(:day)
    column(:price)
    column(:discounts)
    column(:ticket_count)
  end

end
