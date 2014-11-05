Feature: Check balance
  Scenario: Credit account and check balance
    Given my account has a balance of $100
    When I check my balance
    Then I should see a balance of $100
