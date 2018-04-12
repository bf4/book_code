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
  before do
    20.times do
      Customer.create!(first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       email: Faker::Internet.email,
                       username: Faker::Internet.user_name)
    end
  end
  scenario "homepage requires login" do
    sign_up_and_log_in

    visit "/customers"
    within ".search-results tbody" do
      expect(page).to have_selector("tr", count: 10)
    end
    screenshot! filename: "customer-search.png"
  end
end
