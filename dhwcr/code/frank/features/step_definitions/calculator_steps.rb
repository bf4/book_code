#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I have cleared the calculator$/ do
  touch "button marked:'C'"
end

When /^I press "(.+)"$/ do |keys|
  keys.each_char do |k|
    touch "button marked:'#{k}"
  end
end

Then /^the result should be "(.+)"$/ do |expected|
  check_element_exists "label marked:'#{expected}"
end
