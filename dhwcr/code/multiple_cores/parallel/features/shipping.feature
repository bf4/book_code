Feature: Shipping

  Scenario: Packing the containers
    Given an order for 20 tons of material
    When I pack 4 shipping containers
    Then the order should be complete
