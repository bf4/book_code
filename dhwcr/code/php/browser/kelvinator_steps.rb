#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
Given /^a temperature of (\d+) degrees centigrade$/ do |centigrade|
  @centigrade = centigrade.to_i
end

When /^I convert it to Kelvin$/ do
  browser.navigate.to "http://localhost/~#{ENV['USER']}/index.php" 
  input = browser.find_element :name, 'centigrade'
  input.send_keys @centigrade.to_s
  input.submit

  output = browser.find_element :id, 'kelvin'
  @kelvin = output.text.to_i
end

Then /^the result should be (\d+) degrees Kelvin$/ do |expected|
  @kelvin.should == expected.to_i
end
