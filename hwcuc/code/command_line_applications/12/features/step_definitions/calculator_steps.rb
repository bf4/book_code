#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
Given /^the input "([^"]*)"$/ do |input|
  write_file 'input.txt', input
end
When /^the calculator is run$/ do
  run 'calculator input.txt'
end
When /^the calculator is run with no input$/ do
  run_interactive 'calculator'
end
When /^I enter the calculation "([^"]*)"$/ do |calculation|
  type calculation
end
Then /^the output should be "([^"]*)"$/ do |output|
  assert_passing_with output
end

