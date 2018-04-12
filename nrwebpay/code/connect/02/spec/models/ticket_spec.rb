#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Ticket, type: :model do

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:performance) { create(:performance, event: event) }

  it "can move to waiting" do
    ticket = create(:ticket, status: "unsold", performance: performance)
    ticket.place_in_cart_for(user)
    expect(ticket.user).to eq(user)
    expect(ticket.status).to eq("waiting")
  end

  it "can move to purchased" do
    ticket = create(
        :ticket, status: "waiting",
                 user: user, performance: performance)
    ticket.purchased!
    expect(ticket.user).to eq(user)
    expect(ticket.status).to eq("purchased")
  end
end
