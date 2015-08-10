#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

feature "Angular works" do
  include SignUpAndLogin

  scenario "goofy model updaters are good to go" do
    sign_up_and_log_in
    visit "/angular_test"
    screenshot! filename: "angular_test-before.png"
    fill_in "name", with: "Bob"
    within "header h1" do
      expect(page).to have_content "Bob"
    end
    screenshot! filename: "angular_test-after.png"
  end
end
