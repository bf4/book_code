#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe "adding a new task" do
  let!(:project) { create(:project, name: "Project Bluebook") }
  let!(:task_1) { create(
    :task, project: project, title: "Search Sky", size: 1, project_order: 1) }
  let!(:task_2) { create(
    :task, project: project, title: "Use Telescope", size: 1,
           project_order: 2) }
  let!(:task_3) { create(
    :task, project: project, title: "Take Notes", size: 1,
           project_order: 3) }

  it "can re-order a task", :js do
    visit(project_path(project))
    find("#task_3")
    within("#task_3") do
      click_on("Up")
    end
    expect(page).to have_selector(
      "tbody:nth-child(2) .name", text: "Take Notes")
    visit(project_path(project))
    find("#task_2")
    within("#task_2") do
      expect(page).to have_selector(".name", text: "Take Notes")
    end
  end

end
