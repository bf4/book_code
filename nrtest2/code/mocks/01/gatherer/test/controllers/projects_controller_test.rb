#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  #
  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    assert_equal "Runway", assigns[:action].project.name
  end
  #

  #
  test "the project method creates a project (mock version)" do
    fake_action = mock(create: true) 
    CreatesProject.expects(:new)  
        .with(name: "Runway", task_string: "start something:2")
        .returns(fake_action)
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    refute_nil assigns[:action] 
  end
  #

  #
  test "on failure we go back to the form" do
    post :create, project: {name: "", tasks: ""} 
    assert_template :new 
    refute_nil assigns(:project) 
  end
  #

#
  test "fail create gracefully" do
    action_stub = stub(create: false, project: Project.new) 
    CreatesProject.expects(:new).returns(action_stub) 
    post :create, :project => {:name => 'Project Runway'} 
    assert_template('new') 
  end

  test "fail update gracefully" do
    sample = Project.create!(name: "Test Project")
    sample.expects(:update_attributes).returns(false) 
    Project.stubs(:find).returns(sample) 
    patch :update, id: sample.id, project: {name: "Fred"} 
    assert_template('edit') 
  end
#

#
  test "let's stub a class again" do
    Project.stubs(:find).with(1).returns(
        Project.new(:name => "Project Greenlight"))
    Project.stubs(:find).with(2).returns(
        Project.new(:name => "Project Blue Book"))
    assert_equal("Project Greenlight", Project.find(1).name)
    assert_equal("Project Blue Book", Project.find(2).name)
  end
#
end
