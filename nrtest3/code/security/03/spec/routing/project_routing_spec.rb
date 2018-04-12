#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe "project routing", :aggregate_failures, type: :routing do

  it "routes projects" do
    expect(get: "/projects").to route_to(
      controller: "projects", action: "index")
    expect(post: "/projects").to route_to(
      controller: "projects", action: "create")
    expect(get: "/projects/new").to route_to(
      controller: "projects", action: "new")
    expect(get: "/projects/1").to route_to(
      controller: "projects", action: "show", id: "1")
    expect(get: "/projects/1/edit").to route_to(
      controller: "projects", action: "edit", id: "1")
    expect(patch: "/projects/1").to route_to(
      controller: "projects", action: "update", id: "1")
    expect(delete: "/projects/1").to route_to(
      controller: "projects", action: "destroy", id: "1")
  end

end
