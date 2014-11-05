#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'
require 'mocha'
class DiaryEntryTest < ActiveSupport::TestCase
  test "can create a diary entry" do
    SocialActivityStream.stubs(:notice).returns nil
    assert_difference "DiaryEntry.count" do
      DiaryEntry.create!(title: "Hallo Wherld",
                        body: "Kaint spale sahree",
                        user: users("chad"))
    end
  end
  test "post a notice to the social activity stream on creation" do
    title = "Ode to a House DJ"
    SocialActivityStream.expects(:notice).
      with(user: users("chad").social_stream_id,
           body: %{A new diary entry called #{title}
             has been created. Check it out!}).
                                          returns(nil)
    DiaryEntry.create!(title: title,
                       body: "Thump thump thump thump",
                       user: users("chad"))
  end
end
