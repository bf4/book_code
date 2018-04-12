#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe ProjectsHelper, type: :helper do
  let(:project) { Project.new(name: "Project Runway") }

  it "augments with status info when on schedule" do
    allow(project).to receive(:on_schedule?).and_return(true) 
    actual = helper.name_with_status(project)
    expect(actual).to have_selector("span.on_schedule", text: "Project Runway")
  end
end
