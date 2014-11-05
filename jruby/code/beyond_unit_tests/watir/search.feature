Feature: Web search

  In order to tell my searches apart
  As a person who browses in multiple tabs
  I want to see the term I searched for

  Scenario: Page title
    Given I am on the search home page
    When I search for "hello world"
    Then the page title should begin with "hello world"
