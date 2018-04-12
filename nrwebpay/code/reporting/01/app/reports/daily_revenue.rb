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

  attr_accessor :date, :payments

  def self.find_collection
    Payment.includes(payment_line_items: :buyable)
        .all.group_by(&:date).map do |date, payments|
      DailyRevenue.new(date, payments)
    end
  end

  def initialize(date, payments)
    @date = date
    @payments = payments
  end

  def revenue
    payments.sum(&:price)
  end

  def discounts
    payments.sum(&:discount)
  end

  def tickets_sold
    payments.flat_map(&:tickets).size
  end

  columns do
    column(:date)
    column(:tickets_sold)
    column(:revenue)
    column(:discounts)
  end

end
