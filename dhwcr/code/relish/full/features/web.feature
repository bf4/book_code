Feature: Testing web applications

  This section contains several tips for connecting to servers and
  processing HTML.

  Scenario: Parsing HTML tables

    Cucumber's Rails integration used to come with a `tableish()`
    method for extracting HTML table data into Cucumber's internal
    table format.  This behavior has been moved into the various web
    testing libraries.

    Given an HTML table
    When I read the table recipe
    Then I should be able to parse my table easily
