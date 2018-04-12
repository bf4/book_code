#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Performance, type: :model do
  describe "finders" do
    let(:event) { create(:event) }
    let(:performance) { create(:performance, event: event) }
    let(:unsold_ticket) { create(
        :ticket, status: "unsold", performance: performance) }
    let(:sold_ticket) { create(
        :ticket, status: "sold", performance: performance) }

    it "can find unsold tickets" do
      expect(performance.unsold_tickets(1)).to eq([unsold_ticket])
    end
  end
end
