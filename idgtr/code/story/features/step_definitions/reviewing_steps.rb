#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
Then /^the (.*) should be "(.*)"$/ do |setting, value|
  @party.send(setting).should == value
end

Then /^the party should (.*) on (.*)$/ do |event, date_time|
  actual_time =
    (event == 'begin') ?
    @party.begins_at :
    @party.ends_at

  clean = date_time.gsub ',', ' '
  expected_time = Chronic.parse clean, :now => Time.now - 86400

  actual_time.should == expected_time
end

Then /^I should see the Web address to send to my friends$/ do
  @party.link.should match(%r{^http://})
end

