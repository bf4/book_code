Feature: Greet user

  Scenario: Greet users who are logged in
    Given I am logged in as "matt"
    When I visit the homepage
    Then I should see "Hello matt"
