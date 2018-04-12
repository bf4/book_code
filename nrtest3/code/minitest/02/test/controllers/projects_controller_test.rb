#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"

class ProjectsControllerTest < ActionController::TestCase
  test "routing" do
    assert_routing "/projects", controller: "projects", action: "index"
    assert_routing({path: "/projects", method: "post"},
      controller: "projects", action: "create")
    assert_routing "/projects/new", controller: "projects", action: "new"
    assert_routing "/projects/1", controller: "projects",
                                  action: "show", id: "1"
    assert_routing "/projects/1/edit", controller: "projects",
                                       action: "edit", id: "1"
    assert_routing({path: "/projects/1", method: "patch"},
      controller: "projects", action: "update", id: "1")
    assert_routing({path: "/projects/1", method: "delete"},
      controller: "projects", action: "destroy", id: "1")
  end
end
