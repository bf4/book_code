Feature: Stock broker

  Scenario: Buy low, sell high
    Given I have 100 shares of GOOG
    When I sell all my GOOG shares for $800.00/share
    Then I should have $80000.00
