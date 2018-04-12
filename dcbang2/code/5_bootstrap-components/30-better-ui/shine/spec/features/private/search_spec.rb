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
  def not_pat(&block)
    result = block.()
    while result =~ /^pat/i
      result = block.()
    end
    result
  end
  let(:customer_attributes) {
    ->() {
      {
        first_name: not_pat { Faker::Name.first_name },
        last_name: not_pat { Faker::Name.last_name },
        email: not_pat { Faker::Internet.email },
        username: Faker::Internet.user_name
      }
    }
  }
  before do
    10.times do |i|
      Customer.create!(customer_attributes.())
    end
    @matches = [
      Customer.create!(customer_attributes.().merge(first_name: "pat")),
      Customer.create!(customer_attributes.().merge(last_name: "patrica")),
      Customer.create!(customer_attributes.().merge(first_name: "patrick")),
      Customer.create!(customer_attributes.().merge(email: "pat@somewhere.com")),
    ]
  end
  scenario "search by name" do
    sign_up_and_log_in

    visit "/customers"
    fill_in "keywords", with: "pat"
    click_button "Find Customers"

    within ".search-results ol" do
      expect(page).to have_selector("li", count: @matches.size - 1)
    end
  end

  scenario "search by email" do
    sign_up_and_log_in

    visit "/customers"
    fill_in "keywords", with: "pat@somewhere.com"
    click_button "Find Customers"

    within ".search-results ol" do
      expect(page).to have_selector("li", count: @matches.size)
      @matches.each do |customer|
        expect(page).to have_text(customer.first_name)
        expect(page).to have_text(customer.last_name)
        expect(page).to have_text(customer.email)
      end
    end
    screenshot! filename: "customer-search.png"
  end
end
