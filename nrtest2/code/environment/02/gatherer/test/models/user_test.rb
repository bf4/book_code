#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #
  def create_two_projects
    Project.delete_all
    @user = User.create!(email: "user@example.com", password: "password")
    @project_1 = Project.create!(name: "Project 1")
    @project_2 = Project.create!(name: "Project 2")
    @all_projects = [@project_1, @project_2]
  end

  def assert_visiblity_of(*projects)
    assert_equal(@user.visible_projects, projects)
    projects.all? { |p| assert(@user.can_view?(p)) }
    (@all_projects - projects).all? { |p| refute(@user.can_view?(p)) }
  end

  test "a user can see their projects" do
    create_two_projects
    @user.projects << @project_1
    assert_visiblity_of(@project_1)
  end

  test "an admin can see all projects" do
    create_two_projects
    @user.admin = true
    assert_visiblity_of(@project_1, @project_2)
  end

  test "a user can see public projects" do
    create_two_projects
    @user.projects << @project_1
    @project_2.update_attributes(public: true)
    assert_visiblity_of(@project_1, @project_2)
  end

  test "no dupes in project list" do
    create_two_projects
    @user.projects << @project_1
    @project_1.update_attributes(public: true)
    assert_visiblity_of(@project_1)
  end
  #

    #
    test "can get a twitter avatar URL" do
      user = User.new(email: "test@example.com")
      fake_adapter = mock("avatar").responds_like_instance_of(AvatarAdapter)
      fake_adapter.expects(:image_url).returns("fake_url")
      AvatarAdapter.expects(:new).with(user).returns(fake_adapter)
      user.avatar_url
    end
    #
end
