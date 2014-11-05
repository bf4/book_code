#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I am on "(.*?)"$/ do |url|
  visit url
end
When /^I click the "(.*?)" link$/ do |name|
  follow_link_to name
end
Then /^I should see an underlined "(.*?)" link$/ do |name|
  verify_underlined_link_to name
end
