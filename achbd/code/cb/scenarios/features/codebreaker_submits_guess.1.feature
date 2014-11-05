#START:feature
#START:scenario_1
Feature: code-breaker submits guess

  The code-breaker submits a guess of four numbers.  The game marks the guess
  with + and - signs.

  For each number in the guess that matches the number and position of a number
  in the secret code, the mark includes one +. For each number in the guess
  that matches the number but not the position of a number in the secret code,
  a - is added to the mark.
#END:feature

#START:scenario_2
#START:scenario_4
  Scenario: all exact matches
    Given the secret code is "1234"
    When I guess "1234"
    Then the mark should be "++++"
#END:scenario_1

  Scenario: 2 exact matches and 2 number matches
    Given the secret code is "1234"
    When I guess "1243"
    Then the mark should be "++--"
#END:scenario_2

  Scenario: 1 exact match and 3 number matches
    Given the secret code is "1234"
    When I guess "1342"
    Then the mark should be "+---"

  Scenario: 4 number matches
    Given the secret code is "1234"
    When I guess "4321"
    Then the mark should be "----"
#END:scenario_4


