Feature: Cash Withdrawal
  Scenario: Successful withdrawal from an account in credit
    Given my account has been credited with $100
    When I withdraw $20
    Then $20 should be dispensed
    And the balance of my account should be $80
