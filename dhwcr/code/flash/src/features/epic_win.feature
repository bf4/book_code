Feature: Epic Win

  Scenario: Win the game
    Given the game is running
    When I play
    Then I should be the winner
