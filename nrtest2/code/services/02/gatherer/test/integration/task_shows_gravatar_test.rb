#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "test_helper"

class TaskShowsGravatar < Capybara::Rails::TestCase

  include Warden::Test::Helpers

  setup do
    projects(:bluebook).roles.create(user: users(:user))
    users(:user).update_attributes(email: "noelrappin@gmail.com")
    tasks(:one).update_attributes(user_id: users(:user).id,
        completed_at: 1.hour.ago)
    login_as users(:user)
  end

  test "i see a gravatar" do
    VCR.use_cassette("loading_gravatar") do
      visit project_path(projects(:bluebook))
      url = "http://www.gravatar.com/avatar/6b767d8a4c9910e007c122d81eb4de73"
      within("#task_1") do
        assert_selector(".completed", text: users(:user).email)
        assert_selector("img[src='#{url}']")
      end
    end
  end
end
