Feature: Balloon

  Scenario: Pop
    Given a balloon
    When I inflate it for 5 seconds
    Then it should pop
