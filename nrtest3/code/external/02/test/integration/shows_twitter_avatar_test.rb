#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"

class TaskShowsTwitterAvatar < Capybara::Rails::TestCase
  include Warden::Test::Helpers

  setup do
    projects(:bluebook).roles.create(user: users(:user))
    users(:user).update_attributes(twitter_handle: "noelrap")
    tasks(:one).update_attributes(user_id: users(:user).id,
                                  completed_at: 1.hour.ago)
    login_as users(:user)
  end

  test "I see a gravatar" do
    VCR.use_cassette("loading_twitter") do
      visit project_path(projects(:bluebook))
      url = "http://pbs.twimg.com/profile_images/40008602/head_shot_bigger.jpg"
      within("#task_1") do
        assert_selector(".completed", text: users(:user).email)
        assert_selector("img[src='#{url}']")
      end
    end
  end
end
