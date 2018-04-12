#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

describe ProjectPresenter do
  let(:project) { instance_double(Project, name: "Project Runway") }
  let(:presenter) { ProjectPresenter.new(project) }

  it "handles name with on time status" do
    allow(project).to receive(:on_schedule?).and_return(true)
    expect(presenter.name_with_status).to eq(
      "<span class='on_schedule'>Project Runway</span>")
  end

  it "handles name with behind schedule status" do
    allow(project).to receive(:on_schedule?).and_return(false)
    expect(presenter.name_with_status).to eq(
      "<span class='behind_schedule'>Project Runway</span>")
  end
end
