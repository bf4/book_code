#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"

class NavigationTest < ActiveSupport::IntegrationCase
  setup do
    ActionMailer::Base.deliveries.clear
  end
  
  test "sends an e-mail after filling the contact form" do
    visit "/"

    fill_in "Name",    with: "John Doe"
    fill_in "Email",   with: "john.doe@example.com"
    fill_in "Message", with: "MailForm rocks!"

    click_button "Deliver"
    assert_match "Your message was successfully sent.", page.body

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last

    assert_equal ["john.doe@example.com"], mail.from
    assert_equal ["recipient@example.com"], mail.to
    assert_match "Message: MailForm rocks!", mail.body.encoded
  end
end
