#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
Given /^there is a User$/ do
  FactoryGirl.create(:user)
end

Given /^the User has posted the message "([^"]*)"$/ do |message_text|
  User.count.should == 1
  FactoryGirl.create(:message, :content => message_text, :user => User.first)
end

Given /^a User has posted the following messages:$/ do |messages|
  user = FactoryGirl.create(:user)
  messages_attributes = messages.hashes.map do |message_attrs| 
    message_attrs.merge({:user => user})
  end
  Message.create!(messages_attributes)
end

When /^I visit the page for the User$/ do
  User.count.should == 1
  visit(user_path(User.first))
end
