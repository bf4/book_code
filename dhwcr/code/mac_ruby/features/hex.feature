Feature: Hex editor

  Scenario: Convert to integer
    Given a hex editor
    When I type some text
    Then I should be able to view the bytes as an integer
