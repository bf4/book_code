Feature: Calculator

  Scenario: Square
    Given I have cleared the calculator
    When I press "8"
    And I press "x="
    Then the result should be "64"
