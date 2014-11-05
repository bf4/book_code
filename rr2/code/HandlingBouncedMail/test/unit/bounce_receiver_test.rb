#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'bounce_receiver'

class BounceReceiverTest < Test::Unit::TestCase
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

  def test_bounce_receiver_smoke_test
    BounceReceiver.receive(File.read(File.join(File.dirname(__FILE__), "..", "fixtures/bounce_example.txt")))
  end
  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/bounce_receiver/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
