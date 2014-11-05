Feature: We can use gem-man to get a manual page
    As a new user, I can get a more detailed
    page of documentation similar to the UNIX manual
    system.

  Background:
    Given the current code is installed as a gem

  Scenario: Checking that the manual works
    When I run `gem man db_backup`
    Then the output should contain "DB_BACKUP.RB"
