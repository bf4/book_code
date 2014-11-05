#---
# Excerpted from "Web Development Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
#---
Given /^I am on the QED Server home page$/ do
  @selenium.open("/") #
end
Then /^I should see the "([^"]*)" link$/ do |link_text|
  @selenium.element?("link=#{link_text}").should be_true #
end

