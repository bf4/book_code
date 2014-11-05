#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class AvatarAdapterTest < ActiveSupport::TestCase

  test "accurately receives image url" do
    user = stub(twitter_handle: "noelrap")
    VCR.use_cassette("adapter_image_url") do
      adapter = AvatarAdapter.new(user)
      url = "http://pbs.twimg.com/profile_images/40008602/head_shot_bigger.jpg"
      assert_equal url, adapter.image_url
    end
  end

end
