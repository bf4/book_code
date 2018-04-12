#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require 'rails_helper'

feature "sign-up" do
  scenario "we can sign up" do
    visit "/"
    expect(page).to have_content("Log in")

    click_link "Sign up"
    screenshot! filename: "sign-up.png"

    email = "user#{rand(10000)}@example.com"

    fill_in "Email"                 , with:  email
    fill_in "Password"              , with: "qwertyuiop"
    fill_in "Password confirmation" , with: "qwertyuiop"

    click_button "Sign up"

    within "header" do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
    within "aside" do
      expect(page).to have_content("You have signed up successfully")
    end
    screenshot! filename: "dashboard.png"
  end
end
