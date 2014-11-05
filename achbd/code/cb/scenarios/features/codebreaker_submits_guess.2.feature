#START:feature
Feature: code-breaker submits guess

  As a code-breaker
  I want to submit a guess
  So that I can try to break the code
#END:feature

#START:scenario
  Scenario: all exact matches
    Given the secret code is "1234"
    When I guess "1234"
    Then the mark should be "++++"
#END:scenario
