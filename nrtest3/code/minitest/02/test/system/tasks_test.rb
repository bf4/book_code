#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  test "reordering a task" do
    project = FactoryBot.create(:project, name: "Project Bluebook")
    FactoryBot.create(
      :task, project: project, title: "Search Sky", size: 1, project_order: 1)
    FactoryBot.create(
      :task, project: project, title: "Use Telescope", size: 1,
             project_order: 2)
    FactoryBot.create(
      :task, project: project, title: "Take Notes", size: 1,
             project_order: 3)
    visit(project_path(project))
    find("#task_3")
    within("#task_3") do
      click_on("Up")
    end
    assert_selector(
      "tbody:nth-child(2) .name", text: "Take Notes")
    visit(project_path(project))
    find("#task_2")
    within("#task_2") do
      assert_selector(".name", text: "Take Notes")
    end
  end
end
