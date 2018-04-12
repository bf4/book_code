#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require 'rails_helper'
require_relative 'feature_support'

feature "search" do
  include FeatureSupport
  let(:customer_attributes) {
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      username: Faker::Internet.user_name + rand(1000).to_s
    }
  }
  let!(:customer) {
    Customer.create!(customer_attributes).tap { |c|
      c.create_customers_billing_address(address: create_address)
      c.customers_shipping_address.create!(address: create_address,
                                           primary: true)
    }
  }

  scenario "navigate" do
    sign_up_and_log_in
    visit "/customers"
    fill_in "keywords", with: customer.email
    within ".search-results ol" do
      click_on("View Details...", match: :first)
    end
    within ".customer-details" do
      fill_in "first_name", with: ""
      within "aside.alert" do
        expect(page).to have_text("This is required")
      end
    end
    screenshot! filename: "validation-required.png"
    fill_in "first_name", with: "Pat"
    within ".customer-details .Shipping" do
      fill_in "zipcode", with: "abcde"
      within "aside.alert" do
        expect(page).to have_text("This is not a Zip Code")
      end
      fill_in "state", with: ""
      fill_in "city", with: ""
    end
    screenshot! filename: "address-validation-better.png"
    within ".customer-details .Shipping" do
      fill_in "state", with: "DC"
      fill_in "city", with: "Washington"
      fill_in "zipcode", with: "12345"
      expect(page).not_to have_text("This is not a Zip Code")
      fill_in "zipcode", with: "12345-1234-1234"
      within "aside.alert" do
        expect(page).to have_text("This is not a Zip Code")
      end
    end
  end
  def create_address
    state = State.find_or_create_by!(
      code: Faker::Address.state_abbr,
      name: Faker::Address.state)

    Address.create!(
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: state,
      zipcode: Faker::Address.zip)
  end
end

