#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe AddsToCart do

  let(:user) { create(:user) }
  let(:performance) { instance_double(Performance) }
  let(:ticket_1) { instance_spy(Ticket, status: "unsold") }
  let(:ticket_2) { instance_spy(Ticket, status: "unsold") }

  describe "happy path adding tickets" do
    let(:action) { AddsToCart.new(
        user: user, performance: performance, count: 1) }

    before(:example) do
      expect(performance).to receive(:unsold_tickets)
          .with(1).and_return([ticket_1])
    end

    it "adds a ticket to a cart" do
      action.run
      expect(action.success).to be_truthy
      expect(ticket_1).to have_received(:place_in_cart_for).with(user)
      expect(ticket_2).not_to have_received(:place_in_cart_for)
      expect(ShoppingCart.find_by(user_id: user.id)).not_to be_nil
    end

    it "does not create a second shopping cart" do
      ShoppingCart.create(user_id: user.id)
      action.run
      expect(ShoppingCart.where(user_id: user.id).size).to eq(1)
    end
  end

  describe "if there are no tickets, the action fails" do
    it "does not add a ticket to the cart" do
      expect(performance).to receive(:unsold_tickets).with(1).and_return([])
      action = AddsToCart.new(user: user, performance: performance, count: 1)
      action.run
      expect(action.success).to be_falsy
      expect(ticket_1).not_to have_received(:place_in_cart_for)
      expect(ticket_2).not_to have_received(:place_in_cart_for)
    end
  end

end
