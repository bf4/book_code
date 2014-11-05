Feature:
  Scenario: Buy Two Bottles of Shampoo
    Given the price of a bottle of shampoo is $1.99
    When I scan 2 bottles of shampoo
    Then the price should be $0
