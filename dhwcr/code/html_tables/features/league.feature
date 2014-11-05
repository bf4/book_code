Feature: Lawn darts league

  Scenario: View teams
    When I view the league page
    Then I should see the following teams:
      | Ranking | Team            |
      |       1 | Earache My Eye  |
      |       2 | Front Yardigans |
