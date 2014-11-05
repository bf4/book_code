#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
require "fixtures/sample_mail"

class MailFormTest < ActiveSupport::TestCase
  test "sample mail can clear attributes using clear_ prefix" do
    sample = SampleMail.new

    sample.name  = "User"
    sample.email = "user@example.com"
    assert_equal "User", sample.name
    assert_equal "user@example.com", sample.email

    sample.clear_name
    sample.clear_email
    assert_nil sample.name
    assert_nil sample.email
  end

  test "sample mail has name and email as attributes" do
    sample = SampleMail.new
    sample.name = "User"
    assert_equal "User", sample.name
    sample.email = "user@example.com"
    assert_equal "user@example.com", sample.email
  end
end