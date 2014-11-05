#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "test_helper"

class AddTaskTest < Capybara::Rails::TestCase

  test "i can add and reorder a task" do
    visit project_path(projects(:bluebook))
    fill_in "Task", with: "Find UFOs"
    select "2", from: "Size"
    click_on "Add Task"
    assert_equal project_path(projects(:bluebook)), current_path
    within("#task_3") do
      assert_selector(".name", text: "Find UFOs")
      assert_selector(".size", text: "2")
      refute_selector("a", text: "Down")
      click_on("Up")
    end
    assert_equal project_path(projects(:bluebook)), current_path
    within("#task_2") do
      assert_selector(".name", text: "Find UFOs")
    end
  end
end
