Feature: Soda machine
  Scenario: Get soda
    Given I have $2 in my account
    When I wave my magic ring at the machine
    Then I should get a soda
