Feature: Parsing a log
  Scenario: Multiple lines
    Given a log containing:
      """
      W Disk space low
      I Backup complete
      """
    When I parse the log
    Then the entries should be:
      | priority    | message         |
      | warning     | Disk space low  |
      | information | Backup complete |
