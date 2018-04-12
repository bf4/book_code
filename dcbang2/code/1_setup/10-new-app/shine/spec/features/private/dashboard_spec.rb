#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
require "rails_helper"

feature "dashboard works" do
  scenario "going to the dashboard works" do
    visit "/"
    expect(page).to have_content("Welcome to Shine!")
    screenshot! filename: "dashboard.png"
  end
end
