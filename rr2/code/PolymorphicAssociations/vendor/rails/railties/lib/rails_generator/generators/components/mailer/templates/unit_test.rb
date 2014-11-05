#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require '<%= file_name %>'

class <%= class_name %>Test < Test::Unit::TestCase
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

<% for action in actions -%>
  def test_<%= action %>
    @expected.subject = '<%= class_name %>#<%= action %>'
    @expected.body    = read_fixture('<%= action %>')
    @expected.date    = Time.now

    assert_equal @expected.encoded, <%= class_name %>.create_<%= action %>(@expected.date).encoded
  end

<% end -%>
  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/<%= file_name %>/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
