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

When /^I take the square root of (#{A_FLOAT})$/ do |number|
  take_square_root(number)
end

Then /^I should get (#{A_FLOAT})$/ do |expected|
  tolerance = expected.abs * 0.001
  square_root_result.should be_within(tolerance).of(expected)
end
