#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"
class ProjectsHelperTest < ActionView::TestCase
  test "project name with status info" do
    project = Project.new(name: "Project Runway")
    project.stubs(:on_schedule?).returns(true)
    actual = name_with_status(project)
    expected = "<span class='on_schedule'>Project Runway</span>"
    assert_dom_equal(expected, actual)
  end

  test "project name with status info behind schedule" do
    project = Project.new(name: "Project Runway")
    project.stubs(:on_schedule?).returns(false)
    actual = name_with_status(project)
    expected = "<span class='behind_schedule'>Project Runway</span>"
    assert_dom_equal(expected, actual)
  end

  test "project name using assert_select" do
    project = Project.new(name: "Project Runway")
    project.stubs(:on_schedule?).returns(false)
    assert_select_string(name_with_status(project), "span.behind_schedule")
  end
end
