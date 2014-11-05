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

  test "can not view a project it is not a part of" do
    user = User.new
    project = Project.new
    refute user.can_view?(project)
  end

  test "can view a project it is a part of" do
    user = User.create!(email: "user@example.com", password: "password")
    project = Project.create!(name: "Project Gutenberg")
    user.roles.create(project: project)
    assert user.can_view?(project)
  end

  #
  test "an admin user can view a project" do
    user = User.new
    user.admin = true
    project = Project.new
    assert user.can_view?(project)
  end

  test "a public project can be seen by anyone" do
    user = User.new
    project = Project.new
    project.public = true
    assert user.can_view?(project)
  end
  #

end
