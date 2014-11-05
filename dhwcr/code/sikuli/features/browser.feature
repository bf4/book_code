Feature: Browser

  Scenario: Navigate to a magazine
    Given I am on "pragprog.com"
    When I click the "Magazine" link
    Then I should see an underlined "Magazine" link
