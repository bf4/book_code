#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "test_helper"

class UserAndRoleTest < Capybara::Rails::TestCase

  def log_in_as(user) 
    visit new_user_session_path
    fill_in("user_email", :with => user.email)
    fill_in("user_password", :with => user.password)
    click_button("Log in")
  end

  setup do
    @user = User.create(email: "test@example.com", password: "password")
  end

  test "a logged in user can view the project index page" do
    log_in_as(@user)
    visit(projects_path)
    assert_equal projects_path, current_path
  end

  #
  test "without a login, the user can't see the project page" do
    visit(projects_path)
    assert_equal new_user_session_path, current_path
  end
  #

end
