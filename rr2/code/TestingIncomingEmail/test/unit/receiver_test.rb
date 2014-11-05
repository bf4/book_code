#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'receiver'

class ReceiverTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"
  
  
  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
  end

  def test_fixtures_are_working
    email_text = read_fixture("confidential_opportunity").join
    assert_match(/opportunity/i, email_text)
  end
  def test_incoming_email_gets_added_to_database
    count_before = Mail.count
    email_text = read_fixture("confidential_opportunity").join
    Receiver.receive(email_text)
    assert_equal(count_before + 1, Mail.count)
    assert_equal("CONFIDENTIAL OPPORTUNITY", Mail.find(:all).last.subject)
  end
  def test_email_containing_opportunity_rates_higher
    email_text = read_fixture("confidential_opportunity").join
    Receiver.receive(email_text)
    assert(Mail.find_by_subject("CONFIDENTIAL OPPORTUNITY").rating > 0)
  end
  def test_zip_file_increases_rating
    email_text = read_fixture("latest_screensaver").join
    Receiver.receive(email_text)
    assert(Mail.find_by_subject("The latest new screensaver!").rating > 0)
  end
  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/receiver/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
