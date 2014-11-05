Feature: Post Message

  Scenario: Post a message in my feed
    Given I am signed in
    When I post a message
    Then it should appear in my feed
