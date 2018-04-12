#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

describe "projects/index" do

  let(:completed_task) { Task.create!(completed_at: 1.day.ago, size: 1) }
  let(:on_schedule) { Project.create!(
    due_date: 1.year.from_now, name: "On Schedule", tasks: [completed_task]) }
  let(:incomplete_task) { Task.create!(size: 1) }
  let(:behind_schedule) { Project.create!(
    due_date: 1.day.from_now, name: "Behind Schedule",
    tasks: [incomplete_task]) }

  it "renders the index page with correct dom elements" do
    @projects = [on_schedule, behind_schedule]
    render
    expect(rendered).to have_selector(
      "#project_#{on_schedule.id} .on_schedule")
    expect(rendered).to have_selector(
      "#project_#{behind_schedule.id} .behind_schedule")
  end

end
