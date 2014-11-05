#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
When /^I append the ([a-z]+) "([^"]*)"$/ do
  | priority, message |

  @log.append priority, message
end
Then /^the log should read:$/ do |expected|
  @log.contents.should == expected
end

When /^I parse the log$/ do
  @entries = @log.parse
end
Then /^the entries should be:$/ do |table|
  table.diff! @entries
end

Given /^a log containing:$/ do |contents|
  @log = Log.new contents
end
