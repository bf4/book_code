Feature: Reset button

  Scenario: Reset while running
    Given 3 seconds have elapsed
    Then the clock should read "00:03"

    When I reset the clock
    Then the clock should read "00:00"
