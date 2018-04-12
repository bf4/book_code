#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require 'rails_helper'

feature "bootstrap" do
  def sign_up_and_log_in
    visit "/"
    click_link "Sign up"
    email = "user#{rand(10000)}@example.com"
    fill_in "Email", with: email
    fill_in "Password",with: "qwertyuiop"
    fill_in "Password confirmation",with: "qwertyuiop"
    click_button "Sign up"
  end

  def get_to_mockups_page
    sign_up_and_log_in
    visit "/bootstrap_mockups"
  end

  scenario "step one of our grid" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-first-columns.png", selector: "#first-columns"
  end

  scenario "use the grid on a form" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-customer-info-grid.png", selector: "#customer-info-grid"
  end

  scenario "grids. grids everywhere" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-all-grid.png", selector: "#all-grid"
  end

  scenario "panel example" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-panel-example.png", selector: "#panel-example"
  end

  scenario "panels" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-panels.png", selector: "#panels"
  end

  scenario "labels" do
    get_to_mockups_page
    screenshot! filename: "bootstrap-labels.png", selector: "#labels"
  end
end
