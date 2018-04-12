#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe AddsDiscountCodeToCart do

  let!(:code) { create(:discount_code, code: "TEST") }
  let(:user) { create(:user) }

  describe "adds a code to a new cart" do
    let(:workflow) { AddsDiscountCodeToCart.new(user: user, code: "TEST") }

    it "adds a code" do
      workflow.run
      cart = ShoppingCart.for(user: user)
      expect(cart.discount_code).to eq(code)
      expect(workflow).to be_a_success
    end

  end

  describe "is a no-op if the code doesn't exist" do

    let(:workflow) { AddsDiscountCodeToCart.new(user: user, code: "BANANA") }

    it "adds a code" do
      workflow.run
      cart = ShoppingCart.for(user: user)
      expect(cart.discount_code).to be_nil
      expect(workflow).to be_a_success
    end

  end

  describe "with an existing cart and code" do
    let!(:existing_code) { create(:discount_code, code: "EXISTING") }

    before(:example) do
      ShoppingCart.for(user: user).update(discount_code: existing_code)
    end

    context "with a real code" do
      let(:workflow) { AddsDiscountCodeToCart.new(user: user, code: "TEST") }

      it "overrides an existing code" do
        workflow.run
        cart = ShoppingCart.for(user: user)
        expect(cart.discount_code).to eq(code)
        expect(workflow).to be_a_success
      end

    end

    context "with a fake code" do
      let(:workflow) { AddsDiscountCodeToCart.new(user: user, code: "BANANA") }

      it "overrides a code" do
        workflow.run
        cart = ShoppingCart.for(user: user)
        expect(cart.discount_code).to be_nil
        expect(workflow).to be_a_success
      end
    end

  end

end
