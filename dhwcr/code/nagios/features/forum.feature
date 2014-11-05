Feature: Discussion forums

  Scenario: Search
    When I search the forums for "Ruby"
    Then I should see the most recent posts first
