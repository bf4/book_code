Feature: Book landing page
  Scenario: Related titles
    Given I am on the page for "Cucumber Recipes"
    When I look for related titles
    Then I should see "The Cucumber Book"
