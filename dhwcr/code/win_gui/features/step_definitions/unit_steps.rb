#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
A_FLOAT = Transform(/(-?\d+(?:\.\d+)?)/) do |number| 
  number.to_f
end

When /^I convert (#{A_FLOAT}) miles to kilometers$/ do |miles|
  convert_miles_to_km miles
end

Then /^the result should be (#{A_FLOAT}) kilometers$/ do |expected|
  result.should be_within(0.0001).of(expected)
end
