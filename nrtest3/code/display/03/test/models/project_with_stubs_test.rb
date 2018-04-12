#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"

class ProjectWithStubsTest < ActiveSupport::TestCase
  #
  test "let's stub an object" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name) 
    assert_equal(nil, project.name) 
  end
  #

  #
  test "let's stub an object again" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name).returns("Fred")
    assert_equal("Fred", project.name)
  end
  #

  #
  test "let's stub a class" do
    Project.stubs(:find).returns(Project.new(name: "Project Greenlight"))
    project = Project.find(1)
    assert_equal("Project Greenlight", project.name)
  end
  #

  #
  test "let's mock an object" do
    mock_project = Project.new(name: "Project Greenlight")
    mock_project.expects(:name).returns("Fred")
    assert_equal("Fred", mock_project.name)
  end
  #

  #
  test "stub with multiple returns" do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1, 2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end
  #
end
