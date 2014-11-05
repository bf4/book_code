Feature: Cone of silence

  Scenario: Activation
    Given I am writing a book
    When I activate the cone of silence
    Then I should not hear my children for the next hour
