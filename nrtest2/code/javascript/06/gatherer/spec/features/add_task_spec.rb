#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

include Warden::Test::Helpers

describe "adding a new task" do

  #
  fixtures :all
  include Warden::Test::Helpers

  before(:example) do
    projects(:bluebook).roles.create(user: users(:user))
    login_as users(:user)
  end
  #

  it "can add and reorder a task", :js do
    visit project_path(projects(:bluebook))
    fill_in "Task", with: "Find UFOs"
    select "2", from: "Size"
    click_on "Add Task"
    expect(current_path).to eq(project_path(projects(:bluebook)))
    added_task = Task.last
    within("#task_#{added_task.id}") do
      expect(page).to have_selector(".name", text: "Find UFOs")
      expect(page).to have_selector(".size", text: "2")
      expect(page).not_to have_selector("a", text: "Down")
      click_on("Up")
    end
    expect(current_path).to eq(project_path(projects(:bluebook)))
    expect(page).to have_selector("tbody:nth-child(2) .name", text: "Find UFOs")
  end
end
