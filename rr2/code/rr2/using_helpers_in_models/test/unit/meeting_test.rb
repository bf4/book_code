#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  test "has attendees" do
    meeting = Meeting.create
    meeting.attendees << Person.create
    assert_equal 1, meeting.attendees.size
  end
  test "Generates a help summary" do
    meeting = Meeting.create(:subject => "Plan the plan")
    assert_equal "Plan the plan - 0 people attending", meeting.to_s
    meeting.attendees << Person.create(:name => "Haruki")
    assert_equal "Plan the plan - 1 person attending", meeting.to_s
  end
end
