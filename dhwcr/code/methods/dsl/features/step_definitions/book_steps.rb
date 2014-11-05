#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^I am on the page for "(.*?)"$/ do |title|
  visit_book_page title
end

When /^I look for related titles$/ do
  find_related_titles
end

Then /^I should see "(.*?)"$/ do |title|
  verify_related_title title
end
