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
    @user = User.create(email: "test2@example.com", password: "password")
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

  #
  test "a user who is part of a project can see that project" do
    project = Project.create(name: "Project Gutenberg")
    project.roles.create(user: @user)
    log_in_as(@user)
    visit(project_path(project))
    assert_equal project_path(project), current_path
  end

  test "a user who is not part of a project can not see that project" do
    project = Project.create(name: "Project Gutenberg")
    log_in_as(@user)
    visit(project_path(project))
    refute_equal project_path(project), current_path
  end
  #

  #
  test "a user can see projects they are a part of on the index page" do
    my_project = Project.create!(name: "My Project")
    my_project.roles.create(user: @user)
    not_my_project = Project.create!(name: "Not My Project")
    log_in_as(@user)
    visit projects_path
    assert_selector "#project_#{my_project.id}"
    refute_selector "#project_#{not_my_project.id}"
  end
  #

end
