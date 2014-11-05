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


  setup do
    sign_in users(:user)
  end

  #
  test "the index method displays all projects correctly" do
    user = User.new
    project = Project.new(:name => "Project Greenlight")
    @controller.expects(:current_user).returns(user)
    user.expects(:visible_projects).returns([project])
    get :index
    assert_equal assigns[:projects].map(&:__getobj__), [project]
  end
  #

  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"} 
    assert_redirected_to projects_path 
    assert_equal "Runway", assigns[:action].project.name 
  end

  #
  test "the project method creates a project (mock version)" do
    fake_project = mock(create: true)
    CreatesProject.expects(:new)
        .with(name: "Runway", task_string: "start something:2",
            users: [users(:user)])
        .returns(fake_project)
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    refute_nil assigns[:action]
  end

  test "on failure we go back to the form" do
    post :create, project: {name: "", tasks: ""}
    assert_template :new
    refute_nil assigns(:project)
  end

  test "fail create gracefully" do
    assert_no_difference('Project.count') do
      Project.any_instance.expects(:save).returns(false)
      post :create, :project => {:name => 'Project Runway'}
      assert_template('new')
    end
  end

  test "fail update gracefully" do
    sample = Project.create!(name: "Test Project")
    Project.any_instance.expects(:update_attributes).returns(false)
    patch :update, id: projects(:one), project: {name: "Fred"}
    assert_template('edit')
    actual = Project.find(sample.id)
    assert_not_equal("Fred", actual.name)
  end

  #
  test "a user can make a project public" do
    sample = Project.create!(name: "Test Project", public: false)
    patch :update, id: sample.id, project: {public: true}
    refute sample.reload.public
  end
  #

  test "let's stub a class again" do
    Project.stubs(:find).with(1).returns(
        Project.new(:name => "Project Greenlight"))
    Project.stubs(:find).with(2).returns(
        Project.new(:name => "Project Blue Book"))
    assert_equal("Project Greenlight", Project.find(1).name)
    assert_equal("Project Blue Book", Project.find(2).name)
  end

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

  test "a user who is part of the project can see the project" do
    project = Project.create(name: "Project Runway")
    @controller.current_user.stubs(can_view?: true)
    get :show, id: project.id
    assert_template :show
  end

  test "a user who is not part of the project can not see the project" do
    project = Project.create(name: "Project Runway")
    @controller.current_user.stubs(can_view?: false)
    get :show, id: project.id
    assert_redirected_to new_user_session_path
  end

end
