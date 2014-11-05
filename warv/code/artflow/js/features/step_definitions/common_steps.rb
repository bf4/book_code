#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
Given /^I am designer "([^"]*)" with an account$/ do |name|
  email = "#{name.downcase.gsub(' ', '.')}@artflowme.com"
  @user = Designer.create!(name: name, email: email, password: 'testtest')
end

Given /^I sign in$/ do
  visit new_designer_session_path
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => 'testtest')
  click_button('Sign in')
end

Then /^I should see "([^"]*)"$/ do |text|
  has_content?(text)
end
