#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

describe AddsShippingToCart do

  let(:user) { create(:user) }
  let(:address) { attributes_for(:address) }
  let(:workflow) { AddsShippingToCart.new(
      user: user, address: address, method: :standard) }

  it "adds shipping to cart" do
    workflow.run
    cart = ShoppingCart.for(user: user)
    expect(cart.address).to have_attributes(address)
    expect(cart).to be_standard
    expect(workflow).to be_a_success
  end

  it "fails gracefully if a field is missing" do
    address.delete(:zip)
    workflow.run
    cart = ShoppingCart.for(user: user)
    expect(cart.address).to be_nil
    expect(cart.shipping_method).to eq("electronic")
    expect(workflow).not_to be_a_success
  end

end
