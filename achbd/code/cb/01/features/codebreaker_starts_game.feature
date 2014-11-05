#START:title_and_narrative
Feature: code-breaker starts game

  As a code-breaker
  I want to start a game
  So that I can break the code
#END:title_and_narrative

#START:scenario_only
  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "Welcome to Codebreaker!"
    And I should see "Enter guess:"
#END:scenario_only
    
