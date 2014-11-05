#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^(\d+) "(.*?)"s$/ do |count, digit|
  @first = BigInteger.new(digit * count.to_i)
end

When /^I add "(.*?)"$/ do |digits|
  @second   = BigInteger.new(digits)
  @expected = @first.add @second
end

Then /^I should see "(.*?)" with (\d+) "(.*?)"s$/ do |lead, count, digit|
  @actual = BigInteger.new(lead + digit * count.to_i)
  @actual.should == @expected
end
