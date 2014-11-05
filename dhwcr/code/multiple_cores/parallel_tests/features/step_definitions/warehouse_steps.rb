#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^an order for (\d+) tons of material$/ do |tons|
end

When /^I pack (\d+) shipping containers$/ do |count|
  last = count.to_i
  sleep last * 2
end

Then /^the order should be complete$/ do
end

Given /^I have received (\d+) tons of raw material$/ do |tons|
  @received = tons.to_i
end

When /^I unload the order into the warehouse$/ do
  sleep(@received.to_f / 5)
end

Then /^I should have (\d+)% space remaining$/ do |arg1|
end
