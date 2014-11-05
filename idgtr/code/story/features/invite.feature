Feature: minimalist invites
  So that I can get on with ordering snacks
  As a host with lots to do
  I want to plan a party with a minimum of mouse clicks

  Scenario: manual invites
    Given a party called "Celebration"
    And a description of "There's a party goin' on"
    And a location of "Right here"
    And a starting time of September 29, 2010 at 12:30 PM
    And an ending time of September 29, 2010 at 12:35 PM

    When I view the invitation
    Then I should see the Web address to send to my friends
    And the name should be "Celebration"
    And the description should be "There's a party goin' on"
    And the location should be "Right here"
    And the party should begin on September 29, 2010 at 12:30 PM
    And the party should end on September 29, 2010 at 12:35 PM
