Feature: Laboratory
  Scenario: Voltage
    Given an empty test plan
    When I add a test to measure voltage
    Then I should see the following tests:
      | Measurement |
      | voltage     |

