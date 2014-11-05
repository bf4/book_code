#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I have typed "(.*?)"$/ do |text|
  type_in text
end

When /^I view the bytes as an integer$/ do
  click_menu 'Edit', 'Select All'
  @actual = readout_value
end

Then /^I should see "(.*?)"$/ do |expected|
  @actual.should == expected
end
