#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "customer details" do
  include SignUpAndLogin

  xscenario "see the basic details" do
    sign_up_and_log_in
    customer = Customer.create!(
      first_name:    "Robert",
       last_name:    Faker::Name.last_name,
        username: "#{Faker::Internet.user_name}",
           email: "#{Faker::Internet.user_name}@#{Faker::Internet.domain_name}")
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: "rob"
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      click_button "View Details…"
    end
    within "article.customer-details" do
      expect(page).to have_content(customer.id)
      expect(page).to have_content(customer.first_name)
      expect(page).to have_content(customer.last_name)
      expect(page).to have_content(customer.username)
      expect(page).to have_content(customer.email)
      screenshot! filename: "customer-details-bare-bones.png"
    end
  end
end
