Feature: Receiving

  Scenario: Filling the warehouse
    Given I have received 20 tons of raw material
    When I unload the order into the warehouse
    Then I should have 15% space remaining
