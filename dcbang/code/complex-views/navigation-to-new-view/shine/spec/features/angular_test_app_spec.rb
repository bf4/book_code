#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "angular test" do

  let(:email)    { "bob@example.com" }
  let(:password) { "password123" }

  before do
    User.create!(email: email,
                 password: password,
                 password_confirmation: password)
  end

  # tests will go here...



  # setup from before...

  scenario "Our Angular Test App is Working" do
    visit "/angular_test"

    # Log In
    fill_in      "Email",    with: "bob@example.com"
    fill_in      "Password", with: "password123"
    click_button "Log in"

    # Check that we go to the right page
    expect(page).to have_content("Name")

    # Test the page
    fill_in "name", with: "Bob"
    within "header h1" do
      expect(page).to have_content("Hello, Bob")
    end
  end
 
end
