#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "Customer Search" do
  def create_customer(first_name: nil, 
                      last_name: nil,
                      email: nil)

    first_name ||= Faker::Name.first_name
    last_name  ||= Faker::Name.last_name
    email      ||= "#{Faker::Internet.user_name}#{rand(1000)}@" +
                     "#{Faker::Internet.domain_name}"
    Customer.create!(
      first_name: first_name,
       last_name: last_name,
        username: "#{Faker::Internet.user_name}#{rand(1000)}",
           email: email
    )
  end

  let(:email)    { "bob@example.com" }
  let(:password) { "password123" }

  before do
    User.create!(email: email,
                 password: password,
                 password_confirmation: password)

    create_customer first_name: "Robert",
                     last_name: "Aaron"

    create_customer first_name: "Bob",
                     last_name: "Johnson"

    create_customer first_name: "JR",
                     last_name: "Bob"

    create_customer first_name: "Bobby",
                     last_name: "Dobbs"

    create_customer first_name: "Bob", 
                     last_name: "Jones", 
                         email: "bob123@somewhere.net"
    visit "/customers"
    fill_in      "Email",    with: "bob@example.com"
    fill_in      "Password", with: "password123"
    click_button "Log in"
  end

  xscenario "Search by Name" do
    within "section.search-form" do
      fill_in "keywords", with: "bob"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      expect(page.all("ol li.list-group-item")[0]).to have_content("JR")
      expect(page.all("ol li.list-group-item")[0]).to have_content("Bob")

      expect(page.all("ol li.list-group-item")[3]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[3]).to have_content("Jones")
    end
  end
  
  xscenario "Search by Email" do
    within "section.search-form" do
      fill_in "keywords", with: "bob123@somewhere.net"
    end
    within "section.search-results" do
      expect(page).to have_content("Results")
      expect(page.all("ol li.list-group-item").count).to eq(4)

      expect(page.all("ol li.list-group-item")[0]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[0]).to have_content("Jones")

      expect(page.all("ol li.list-group-item")[1]).to have_content("JR")
      expect(page.all("ol li.list-group-item")[1]).to have_content("Bob")

      expect(page.all("ol li.list-group-item")[3]).to have_content("Bob")
      expect(page.all("ol li.list-group-item")[3]).to have_content("Johnson")
    end
  end
end
