#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe "task display" do

  let(:project) { create(:project, name: "Project Bluebook") }
  let(:user) { create(:user, twitter_handle: "noelrap") }
  let!(:task) { create(:task, project: project, user: user,
                              completed_at: 1.hour.ago, project_order: 1) }

  before(:example) do
    project.roles.create(user: user)
    sign_in(user)
  end

  it "shows a gravatar", :vcr do
    visit project_path(project)
    url = "http://pbs.twimg.com/profile_images/40008602/head_shot_bigger.jpg"
    within("#task_1") do
      expect(page).to have_selector(".completed", text: user.email)
      expect(page).to have_selector("img[src='#{url}']")
    end
  end

end
