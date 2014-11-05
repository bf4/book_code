#---
# Excerpted from "Web Development Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
#---
Given /^I am on the Products management page$/ do
  @selenium.open("/products")
end

Given /^I created a product called "([^"]*)" with a price of "([^"]*)" 
dollars and a description of "([^"]*)"$/ do |name, price, description|
  @selenium.type("product_name", name) #
  @selenium.type("product_price", price)#
  @selenium.type("product_description", description) #
  @selenium.click("css=input[value='Add Product']")#
end

When /^I view the details of "([^"]*)"$/ do |product_name|
  @selenium.is_element_present("css=td:nth(0):contains(#{product_name})")
  @selenium.click("css=td:nth(1) > a:contains(Details)")
end

Then /^I should see a price of "([^"]*)"$/ do |price|
  Then "I should see \"#{price}\""
end

Then /^I should see a description of "([^"]*)"$/ do |description|
  Then "I should see \"#{description}\""
end

