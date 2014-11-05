Feature: Sessions
  In order to safely access my account
  As a user
  I want to manage my session

  # START:signin
  Scenario: Designer can sign in
    Given I am designer "Lindsay Bluth" with an account
    And I sign in
    Then I should see "Welcome, Lindsay Bluth"
  # END:signin
