#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require 'rails_helper'

feature "dashboard" do
  scenario "sign up, go to the homepage, log out" do
    visit "/"
    expect(page).to have_content("Log in")
    screenshot! filename: "sign-in.png"
    click_link "Sign up"
    screenshot! filename: "sign-up.png"
    email = "user#{rand(10000)}@example.com"
    fill_in "Email", with: email
    fill_in "Password",with: "qwertyuiop"
    fill_in "Password confirmation",with: "qwertyuiop"
    click_button "Sign up"
    within "header" do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
    within "section" do
      expect(page).to have_content("Future home of Shine's Dashboard")
    end
    screenshot! filename: "dashboard.png"
    click_link "Log Out"
    expect(page).not_to have_content("Welcome to Shine")
    expect(page).to have_content("Log in")
  end

  scenario "sign up using a bad email and password" do
    visit "/"
    expect(page).to have_content("Log in")
    click_link "Sign up"
    email = "user#{rand(10000)}@rival-example.com"
    fill_in "Email", with: email
    fill_in "Password",with: "1234"
    fill_in "Password confirmation",with: "1234"
    click_button "Sign up"
    within "#error_explanation" do
      expect(page).to have_content "Password is too short (minimum is 10 characters)"
      expect(page).to have_content "Email is invalid"
    end
    screenshot! filename: "failed-registration.png"
  end

  scenario "log in incorrectly" do
    visit "/"
    expect(page).to have_content("Log in")
    click_button "Log in"
    screenshot! filename: "sign-in-error.png"
    expect(page).to have_content("Invalid Email or password")
  end
end
