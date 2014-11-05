Feature: Bookmarks

  Scenario: Bookmark a URL
    When I bookmark "http://pragprog.com"
    Then I should see the following bookmarks:
      | url                 |
      | http://pragprog.com |
