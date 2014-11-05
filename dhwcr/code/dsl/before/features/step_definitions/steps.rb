#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Before { visit '/reset' }
When /^I visit the homepage$/ do
  visit '/'
end
Given /^I am logged in as "(.*?)"$/ do |username|
  # create account
  visit '/'
  click_link 'create an account'
  fill_in 'Username', with: username
  click_button 'Create My Account'
  click_button 'Log Out'
  # log in
  click_link 'log in'
  fill_in 'Username', with: username
  click_button 'Log in'
end
Then /^I should see "(.*?)"$/ do |expected_text|
  page.should have_content(expected_text)
end
