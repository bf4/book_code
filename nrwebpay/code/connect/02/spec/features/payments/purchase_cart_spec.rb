#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"
require "fake_stripe"

describe "purchasing a cart", :js do
  fixtures :all

  before(:each) do
    FakeStripe.stub_stripe
  end

  after(:each) do
    WebMock.reset!
    Stripe.api_key = Rails.application.secrets.stripe_secret_key
  end

  it "can add a purchase to a cart", :slow do
    tickets(:midsummer_bums_1).place_in_cart_for(users(:buyer))
    tickets(:midsummer_bums_2).place_in_cart_for(users(:buyer))
    login_as(users(:buyer), scope: :user)
    visit shopping_cart_path
    fill_in :credit_card_number, with: "4242 4242 4242 4242"
    fill_in :expiration_date, with: "12 / #{Time.current.year + 1}"
    fill_in :cvc, with: "123"
    click_on "purchase"
    # expect(page).to have_selector(".purchased_ticket", count: 2)
    # expect(page).to have_selector(
    #     "#purchased_ticket_#{tickets(:midsummer_bums_1).id}")
    # expect(page).to have_selector(
    #     "#purchased_ticket_#{tickets(:midsummer_bums_2).id}")
  end

  context "can add a discount code" do

    it "comes back to the form on a discount", :slow do

      tickets(:midsummer_bums_1).place_in_cart_for(users(:buyer))
      tickets(:midsummer_bums_2).place_in_cart_for(users(:buyer))
      login_as(users(:buyer), scope: :user)
      visit shopping_cart_path
      fill_in :discount_code, with: "CODE"
      click_on "apply_code"
      expect(page).to have_selector(".active_code", text: "CODE")
      expect(page).to have_selector(".total", text: "$23.50")

    end

  end

  context "can add a shipping method", :vcr do

    it "comes back to the cart with shipping" do
      tickets(:midsummer_bums_1).place_in_cart_for(users(:buyer))
      tickets(:midsummer_bums_2).place_in_cart_for(users(:buyer))
      login_as(users(:buyer), scope: :user)
      visit shopping_cart_path
      click_on "shipping_details"
      fill_in "address_address_1", with: "1060 W. Addison"
      fill_in "address_city", with: "Chicago"
      select "Illinois", from: "address_state"
      fill_in "address_zip", with: "60613"
      select "Overnight", from: "shipping_method"
      click_on "add_address"
      expect(page).to have_selector(
          ".active_shipping_method", text: "overnight")
      expect(page).to have_selector(".total", text: "$42.13")
    end
  end

end
