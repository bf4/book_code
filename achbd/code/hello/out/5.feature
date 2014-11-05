Feature: greeter says hello
  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

Scenario: greeter says hello          \
                     # features/greeter_says_hello.feature:7
  Given a greeter                     \
                     # features/step_definitions/greeter_steps.rb:7
  When I send it the greet message    \
                     # features/step_definitions/greeter_steps.rb:11
  Then I should see "Hello Cucumber!" \
                     # features/step_definitions/greeter_steps.rb:15

1 scenario (1 passed)
3 steps (3 passed)
0m0.003s
