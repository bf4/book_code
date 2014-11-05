Feature: The script uses proper exit codes
  As someone who wants to make a database backup
  The app uses exit codes properly so that it can be used in other contexts

  Scenario: Check that the proper database command gets run
    Given we are configured to not actually run mysqldump
    When I run `db_backup.rb foo`
    Then the output should contain:
    """
    mysqldump foo
    """

  Scenario: Check that the proper database command gets run when using user/pass
    Given we are configured to not actually run mysqldump
    When I run `db_backup.rb -u dave.c -p D4V3 foo`
    Then the output should contain:
    """
    mysqldump -udave.c -pD4V3 foo
    """
    And the exit status should be 0

  Scenario: Check that bad options gets a nonzero exit code
    Given we are configured to not actually run mysqldump
    When I run `db_backup.rb -x`
    Then the exit status should not be 0

  Scenario: Check that missing database gets a nonzero exit code
    Given we are configured to not actually run mysqldump
    When I run `db_backup.rb -u dave.c -p D4V3`
    Then the exit status should not be 0

  Scenario: Check that we actually detect mysqldump errors
    Given we are configured to actually run mysqldump
    When I run `db_backup.rb foobar`
    Then the output should contain:
    """
    There was a problem running 'mysqldump foobar > foobar.sql'
    """
    And the exit status should not be 0

