#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

describe AvatarAdapter do

  it "accurately receives image url", :vcr do
    user = double(twitter_handle: "noelrap")
    adapter = AvatarAdapter.new(user)
    url = "http://pbs.twimg.com/profile_images/40008602/head_shot_bigger.jpg"
    expect(adapter.image_url).to eq(url)
  end

end
