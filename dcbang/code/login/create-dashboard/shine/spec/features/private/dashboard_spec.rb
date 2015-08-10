#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "dashboard" do
  scenario "homepage" do
    visit "/"
    within "header" do
      expect(page).to have_content("Welcome to Shine")
    end
    within "section" do
      expect(page).to have_content("Future home of Shine's Dashboard")
    end
    screenshot! filename: "dashboard.png"
  end
end
