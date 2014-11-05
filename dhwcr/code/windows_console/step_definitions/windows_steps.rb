#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I am on Windows$/ do
  # pass
end

When /^I run Cucumber$/ do
  fail 'This is what a failing step looks like'
end

When /^my step contains an accented (.+)$/ do |s|
end

Then /^I should see colors$/ do
  pending
end

Then /^it should show up in the output$/ do
  pending
end
