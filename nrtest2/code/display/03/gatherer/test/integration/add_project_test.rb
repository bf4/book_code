#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "test_helper"

class AddProjectTest < Capybara::Rails::TestCase
  test "a user can add a a project and give it tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\nTask2:5"
    click_on("Create Project")
    visit projects_path
    @project = Project.find_by_name("Project Runway")
    assert_selector("#project_#{@project.id} .name", text: "Project Runway")
    assert_selector("#project_#{@project.id} .total-size", text: "8")
  end

end




