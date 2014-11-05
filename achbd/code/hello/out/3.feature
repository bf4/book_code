Feature: greeter says hello
  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

Scenario: greeter says hello          # features/greeter_says_hello.feature:7
  Given a greeter                     # features/greeter_says_hello.feature:8
  When I send it the greet message    # features/greeter_says_hello.feature:9
  Then I should see "Hello Cucumber!" # features/greeter_says_hello.feature:10

1 scenario (1 undefined)
3 steps (3 undefined)
0m0.003s

You can implement step definitions for undefined steps with these snippets:

Given /^a greeter$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I send it the greet message$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

