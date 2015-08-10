#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "customers search" do
  include SignUpAndLogin

  xscenario "see the search form and sample results" do
    sign_up_and_log_in
    2.times do |i|
      Customer.create!(
        first_name:    "Robert",
         last_name:    Faker::Name.last_name,
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    2.times do |i|
      Customer.create!(
        first_name:    Faker::Name.first_name,
         last_name: "Bob",
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    Customer.create!(
      first_name:    Faker::Name.first_name,
       last_name: "Bobby",
        username: "#{Faker::Internet.user_name}5",
           email: "#{Faker::Internet.user_name}5@#{Faker::Internet.domain_name}")
    Customer.create!(
      first_name: "Robert",
       last_name: "Jones",
        username: "bobby_#{Faker::Internet.user_name}",
           email: "bob123@somewhere.net")
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: "bob"
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(3)
      screenshot! filename: "customer-search-bob.png"
    end
    fill_in "keywords", with: "bobby"
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      expect(page.all("ol li.list-group-item").count).to eq(1)
      screenshot! filename: "customer-search-bobby.png"
    end
  end
end
