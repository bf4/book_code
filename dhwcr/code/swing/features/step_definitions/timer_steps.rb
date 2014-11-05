#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^(\d+) seconds have elapsed$/ do |seconds|
  reset
  sleep seconds.to_f
end

When /^I reset the clock$/ do
  reset
end

Then /^the clock should read "(.*?)"$/ do |expected|
  look_for_text expected
end
