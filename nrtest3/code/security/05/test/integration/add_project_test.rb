#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"

class AddProjectTest < ActionDispatch::IntegrationTest
  test "allows a user to create a project with tasks" do
    post(projects_path, params: {project:
      {name: "Project Runway", tasks: "Choose Fabric:3\nMake it Work:5"}})
    @project = Project.find_by(name: "Project Runway")
    follow_redirect!
    assert_select("#project_#{@project.id} .name", "Project Runway")
    assert_select("#project_#{@project.id} .total-size", text: "8")
  end

  test "does not allow a user to create a project without a name" do
    post(projects_path, params: {project:
      {tasks: "Choose Fabric:3\nMake it Work:5"}})
    assert_select(".new_project")
  end

  test "behaves correctly with a database failure" do
    workflow = stub(success?: false, create: false, project: Project.new)
    CreatesProject.stubs(:new)
      .with(name: "Project Runway",
            task_string: "Choose Fabric:3\nMake it Work:5")
      .returns(workflow)
    post(projects_path, params: {project:
      {name: "Project Runway", tasks: "Choose Fabric:3\nMake it Work:5"}})
    @project = Project.find_by(name: "Project Runway")
    assert_select(".new_project")
  end
end
