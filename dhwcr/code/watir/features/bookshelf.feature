Feature: Bookshelf

  Scenario: Purchased books
    Given I am logged in
    When I view my account
    Then I should see a sorted list of purchased books
