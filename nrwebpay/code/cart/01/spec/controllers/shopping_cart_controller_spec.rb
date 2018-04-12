#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe ShoppingCartsController do

  describe "update" do
    let(:user) { instance_spy(User) }
    let(:performance) { instance_spy(
        Performance, event: build_stubbed(:event)) }
    let(:action) { instance_spy(AddsToCart) }

    before(:example) do
      allow(@controller).to receive(:current_user).and_return(user)
      allow(Performance).to receive(:find).with("2").and_return(performance)
      allow(AddsToCart).to receive(:new).with(
          performance: performance, count: "1", user: user).and_return(action)
    end

    it "calls add to cart on a successful" do
      allow(action).to receive(:success).and_return(true)
      patch :update, params: {performance_id: "2", ticket_count: "1"}
      expect(action).to have_received(:run)
      expect(@controller).to redirect_to(shopping_cart_path)
    end

    it "redirects back to the event if unsuccessful" do
      allow(action).to receive(:success).and_return(false)
      patch :update, params: {performance_id: "2", ticket_count: "1"}
      expect(action).to have_received(:run)
      expect(@controller).to redirect_to(performance.event)
    end
  end

end
