#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
Given /^the price of a bottle of shampoo is \$(\d+)\.(\d+)$/ do |arg1, arg2|
end

When /^I scan (\d+) bottles of shampoo$/ do |arg1|
end

Then /^the price should be \$(\d+)$/ do |arg1|
  (1.99).should == 0
end