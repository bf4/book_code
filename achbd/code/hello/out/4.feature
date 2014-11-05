Feature: greeter says hello
  In order to start learning RSpec and Cucumber
  As a reader of The RSpec Book
  I want a greeter to say Hello

Scenario: greeter says hello \        
                             # features/greeter_says_hello.feature:7
  Given a greeter            \
                             # features/step_definitions/greeter_steps.rb:1
    uninitialized constant CucumberGreeter (NameError)
    ./features/step_definitions/greeter_steps.rb:2:in `/^a greeter$/'
    features/greeter_says_hello.feature:8:in `Given a greeter'
  When I send it the greet message    \
                             # features/step_definitions/greeter_steps.rb:5
  Then I should see "Hello Cucumber!" \
                             # features/step_definitions/greeter_steps.rb:9

Failing Scenarios:
cucumber features/greeter_says_hello.feature:7 # Scenario: greeter says hello

1 scenario (1 failed)
3 steps (1 failed, 2 skipped)
0m0.003s
