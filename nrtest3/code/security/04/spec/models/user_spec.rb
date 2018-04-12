#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe User, type: :model do
  let(:project) { create(:project) }
  let(:user) { create(:user) }

  describe "visibility" do

    it "cannot view a project it is not a part of" do
      expect(user.can_view?(project)).to be_falsy
    end

    it "can view a project it is a part of" do
      Role.create(user: user, project: project)
      expect(user.can_view?(project)).to be_truthy
    end

  end

  #
  describe "public roles" do
    it "allows an admin to view a project" do
      user.admin = true
      expect(user.can_view?(project)).to be_truthy
    end

    it "allows an user to view a public project" do
      project.public = true
      expect(user.can_view?(project)).to be_truthy
    end
  end

  #
  describe "visible projects" do
    let!(:project_1) { create(:project, name: "Project 1") }
    let!(:project_2) { create(:project, name: "Project 2") }

    it "allows a user to see their projects" do
      user.projects << project_1
      expect(user.visible_projects).to eq([project_1])
    end

    it "allows an admin to see all projects" do
      user.admin = true
      expect(user.visible_projects).to match_array(Project.all)
    end

    it "allows a user to see public projects" do
      user.projects << project_1
      project_2.update(public: true)
      expect(user.visible_projects).to match_array([project_1, project_2])
    end

    it "has no duplicates in project list" do
      user.projects << project_1
      project_1.update(public: true)
      expect(user.visible_projects).to match_array([project_1])
    end
  end
  #
end
