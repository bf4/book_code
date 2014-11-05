Feature: Big calculations

  Scenario: Googol
    Given 100 "9"s
    When I add "1"
    Then I should see "1" with 100 "0"s
