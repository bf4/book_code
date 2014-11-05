#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class ReceiverTest < ActionMailer::TestCase
  test "fixtures are working" do
    email_text = read_fixture("confidential_opportunity").join
    assert_match /opportunity/i, email_text
  end
  test "incoming mail gets added to the database" do
    assert_difference "MailMessage.count" do
      email_text = read_fixture("confidential_opportunity").join
      Receiver.receive(email_text)
      assert_equal "CONFIDENTIAL OPPORTUNITY", MailMessage.last.subject
    end
  end
  test "email containing opportunity rates higher" do
    email_text = read_fixture("confidential_opportunity").join
    Receiver.receive(email_text)
    assert MailMessage.find_by_subject("CONFIDENTIAL OPPORTUNITY").rating > 0
  end
  test "zip file increases rating" do
    email_text = read_fixture("latest_screensaver").join
    Receiver.receive(email_text)
    #assert MailMessage.find_by_subject("The latest new screensaver!").rating > 0
  end
end
