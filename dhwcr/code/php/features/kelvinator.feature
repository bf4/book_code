Feature: Kelvinator

  Scenario: Centigrade to Kelvin
    Given a temperature of 100 degrees centigrade
    When I convert it to Kelvin
    Then the result should be 373 degrees Kelvin
