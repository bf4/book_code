#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe "task controller requests" do
  let(:project) { create(:project, name: "Project Bluebook") }
  let(:user) { create(:user) }

  describe "creation" do
    before(:example) do
      login_as(user)
    end

    it "can add a task to a project the user can see", :js do
      Role.create(user: user, project: project)
      post(tasks_path, params: {task: {name: "New Task", size: "3"}})
      expect(request).to redirect_to(project_path(project))
    end

    it "can not add a task to a project the user can see", :js do
      post(tasks_path, params: {task: {name: "New Task", size: "3"}})
      expect(request).to redirect_to(new_user_session_path)
    end

  end
end
