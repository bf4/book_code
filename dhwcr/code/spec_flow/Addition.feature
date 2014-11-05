Feature: Addition

In order to know my total grocery bill
As a shopper
I want to add numbers

  Scenario: Add two numbers

    Given I have cleared the calculator
    When I enter 2
    And I add 2
    Then the result should be 4
