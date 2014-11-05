Feature: Appending to a log
  Scenario: Initially empty log
    Given a log containing:
      """
      """
    When I append the warning "Disk space low"
    Then the log should read:
      """
      W Disk space low
      """
