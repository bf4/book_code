#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'spec_helper'

describe ProjectsHelper do
  let(:project) { Project.new(name: "Project Runway")}

  it "returns a project name with status info" do
    allow(project).to receive(:on_schedule?).and_return(true)
    expected = '<span class="on_schedule">Project Runway</span>'
    expect(helper.name_with_status(project)).to eq(expected)
  end

  it "returns a project name with status info" do
    allow(project).to receive(:on_schedule?).and_return(false)
    expected = '<span class="behind_schedule">Project Runway</span>'
    expect(helper.name_with_status(project)).to eq(expected)
  end
end
