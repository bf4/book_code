#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Plan, type: :model do
  let(:plan) { build_stubbed(:plan) }

  context "end date" do

    it "calculates daily end date" do
      plan.interval = "day"
      date = Date.parse("July 2, 2016")
      expect(plan.end_date_from(date)).to eq(Date.parse("July 3, 2016"))
    end

  end
end
