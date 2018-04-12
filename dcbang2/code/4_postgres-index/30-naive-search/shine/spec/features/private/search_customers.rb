#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require 'rails_helper'

feature "customers search" do
  def sign_up_and_log_in
    visit "/"
    click_link "Sign up"
    email = "user#{rand(10000)}@example.com"
    fill_in "Email", with: email
    fill_in "Password",with: "qwertyuiop"
    fill_in "Password confirmation",with: "qwertyuiop"
    click_button "Sign up"
    within "header" do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
  end
  scenario "see the search form and sample results" do
    sign_up_and_log_in
    puts Rails.env
    10.times do |i|
      Customer.create!(
        first_name:    Faker::Name.first_name,
         last_name:    Faker::Name.last_name,
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input#keywords")
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("table tbody tr").count).to eq(10)
    end
    screenshot! filename: "customer-search.png"
  end
end
