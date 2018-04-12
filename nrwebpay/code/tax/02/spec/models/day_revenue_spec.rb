#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe DayRevenue, type: :model do

  let!(:really_old_payment) { create(
      :payment, created_at: 1.month.ago, price_cents: 4500) }
  let!(:really_old_payment_2) { create(
      :payment, created_at: 1.month.ago, price_cents: 1500) }
  let!(:old_payment) { create(
      :payment, created_at: 2.days.ago, price_cents: 3500) }
  let!(:ticket) { create(:ticket) }
  let!(:payment_line_item) { create(
      :payment_line_item, payment: really_old_payment, buyable: ticket,
                          created_at: 1.month.ago) }

  it "builds data" do
    revenue = DayRevenue.build_for(1.month.ago)
    expect(revenue.price_cents).to eq(6000)
    expect(revenue.ticket_count).to eq(1)
  end

end
