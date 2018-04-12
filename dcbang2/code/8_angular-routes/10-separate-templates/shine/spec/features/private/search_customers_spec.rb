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
    5.times do |i|
      Customer.create!(
        first_name: "Pat",
         last_name:    Faker::Name.last_name,
          username: "#{Faker::Internet.user_name}#{i}",
             email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}")
    end
    Customer.create!(
      first_name: "Patricia",
       last_name:    Faker::Name.last_name,
        username: "#{Faker::Internet.user_name}99",
           email: "#{Faker::Internet.user_name}99@#{Faker::Internet.domain_name}")
    Customer.create!(
      first_name: "Patricia",
       last_name:    Faker::Name.last_name,
        username: "#{Faker::Internet.user_name}66",
           email: "#{Faker::Internet.user_name}66@#{Faker::Internet.domain_name}")
    Customer.create!(
      first_name: "Pat",
       last_name: "Jones",
        username: "patty_#{Faker::Internet.user_name}",
           email: "pat123@somewhere.net")
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input#keywords")
      fill_in "keywords", with: "pat"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(8)
    end
    screenshot! filename: "customer-search-pat.png"
    within "section.search-form" do
      fill_in "keywords", with: "patricia"
      sleep 0.5
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(2)
    end
    screenshot! filename: "customer-search-patricia.png"
  end
end
