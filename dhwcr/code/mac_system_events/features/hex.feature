Feature: Hex editor

  Scenario: Convert to integer
    Given I have typed "ABCD"
    When I view the bytes as an integer
    Then I should see "-12885"
