#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe DayRevenueReport, type: :model do

  let!(:really_old_payment) { create(
      :payment, created_at: 1.month.ago, price_cents: 4500) }
  let!(:really_old_payment_2) { create(
      :payment, created_at: 1.month.ago, price_cents: 1500) }
  let!(:old_payment) { create(
      :payment, created_at: 2.days.ago, price_cents: 3500) }
  let!(:yesterday_payment) { create(
      :payment, created_at: 1.day.ago, price_cents: 2500) }
  let!(:now_payment) { create(
      :payment, created_at: 1.second.ago, price_cents: 1500) }

  before(:example) do
    BuildDayRevenueJob.perform_now
  end

  it "generates the expected report" do
    enum = DayRevenueReport.to_csv_enumerator
    expect(enum.next).to eq("Day,Price,Discounts,Ticket count\n")
    expect(enum.next).to eq("#{1.month.ago.to_date},60.00,0.00,0\n")
    expect(enum.next).to eq("#{2.days.ago.to_date},35.00,0.00,0\n")
    expect(enum.next).to eq("#{1.day.ago.to_date},25.00,0.00,0\n")
    expect(enum.next).to eq("#{Date.current},15.00,0.00,0\n")
  end
end
