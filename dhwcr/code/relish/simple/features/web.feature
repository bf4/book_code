Feature: Testing web applications

  This section contains several tips for connecting to servers and
  processing HTML.

  Scenario: Parsing HTML tables

    Given an HTML table
    When I read the table recipe
    Then I should be able to parse my table easily
