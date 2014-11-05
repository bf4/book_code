Feature: Furious Fowls game

  @integration
  Scenario: New game
    Given I see 3 buildings
    When I slingshot a bird
    Then I should see 2 buildings
