Feature: Comments
  In order to guide work on a creation
  As a user
  I want to read and add creation comments

  # START:background1
  # START:background2
  Background:
    Given I am designer "Lindsay Bluth" with an account
  # END:background1
  # START_HIGHLIGHT
    And a creation
  # END_HIGHLIGHT
  # START:background1
    And I sign in
  # END:background1
  # END:background2

  # START:empty
  Scenario: Designer sees form when comments empty
    When I go to the creation's page
    Then there should be 0 comments
    Then the comment form should be visible
  # END:empty

  # START:add
  @javascript
  Scenario: Designer adds comment
    When I go to the creation's page
    Then there should be 0 comments
    When I enter a comment and submit it
    Then there should be 1 comment
  # END:add
