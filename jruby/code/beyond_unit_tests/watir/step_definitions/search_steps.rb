#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
Given /^I am on the search home page$/ do
  $browser.goto 'http://www.yahoo.com'
end

When /^I search for "([^\"]*)"$/ do |term|
  $browser.text_field(:name, 'p').set term
  $browser.button(:id, 'search-submit').click
  $browser.wait
end

Then /^the page title should begin with "([^\"]*)"$/ do |title|
  $browser.title[0...title.length].should == title
end
