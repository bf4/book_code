#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

describe User do

  it "can not view a project it is not a part of" do
    user = User.new
    project = Project.new
    expect(user.can_view?(project)).to be_falsy
  end

  it "can view a project it is a part of" do
    user = User.create!(email: "user@example.com", password: "password")
    project = Project.create!(name: "Project Gutenberg")
    user.roles.create(project: project)
    expect(user.can_view?(project)).to be_truthy
  end

  #
  describe "public roles" do
    let(:user) { User.new }
    let(:project) { Project.new }

    it "allows an admin to view a project" do
      user.admin = true
      expect(user.can_view?(project)).to be_truthy
    end

    it "allows a public project to be seen by anyone" do
      project.public = true
      expect(user.can_view?(project)).to be_truthy
    end
  end
  #
end
