Feature: Thermostat

  Scenario: Air conditioning
    Given the room is at 80 F
    When I set the thermostat to 75 F
    Then the A/C should be on
