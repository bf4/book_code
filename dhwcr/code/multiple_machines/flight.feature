Feature: Flights
  @group1
  Scenario: Route exists
    Given a nonstop flight exists
    When I plan my trip
    Then I should see the nonstop options first

  @group2
  Scenario: No route exists
    Given no nonstop flight exists
    When I plan my trip
    Then I should be shown connecting flights
