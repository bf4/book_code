#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
Given /^a guest list of "(.*)"$/ do |list|
  @party.recipients = list
end

Then /^I should see that e-mail was sent to "(.*)"$/ do |list|
  @party.notice.include?(list).should be_true
end

When /^I view the e-mail that was sent to "(.*)"$/ do |address|
  @email = @party.email_to address
end

Then /^I should see "Yes\/No" links$/ do
  @email.should match(%r{Yes - http://})
  @email.should match(%r{No - http://})
end

When /^I follow the "(.*)" link$/ do |answer|
  link = %r{#{answer} - (http://.+)}.match(@email)[1]
  @party.rsvp_at link
end
