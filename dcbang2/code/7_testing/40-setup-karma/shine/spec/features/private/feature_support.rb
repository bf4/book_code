#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
module FeatureSupport
  def sign_up_and_log_in
    visit "/"

    click_link "Sign up"

    email = "user#{rand(10000)}@example.com"
    password = "qwertyuiop"

    fill_in "Email"                 , with: email
    fill_in "Password"              , with: password
    fill_in "Password confirmation" , with: password

    click_button "Sign up"
  end
end
