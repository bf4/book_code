#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
Then /^I should see the party details$/ do
  @party.should have_name
  @party.should have_description
  @party.should have_location
  @party.should have_times
end

When /I answer that "(.*)" will( not)? attend/ do |guest, answer|
  attending = !answer.include?('not')
  @party.rsvp guest, attending
end

Then /^I should see "(.*)" in the list of (.*)$/ do |guest, type|
  want_attending = (type == 'partygoers')
  @party.responses(want_attending).should include(guest)
end
