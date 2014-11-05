Feature: We can get options from a config file
  In order to not have to do so much typing
  We want better defaults stored in a configuration file

  Scenario: We don't overwrite files by default
    Given an empty file named "big_client.sql"
    And no configuration file
    When I run `db_backup.rb big_client`
    Then the exit status should not be 0
    And the stderr should contain:
    """
    error: big_client.sql exists, use --force to overwrite
    """

  Scenario: We can be forced to overwrite a file via a configuration file
    Given an empty file named "big_client.sql"
    And a yaml configuration file that specifies that "force" is "true"
    When I run `db_backup.rb big_client`
    Then the stderr should contain:
    """
    Overwriting big_client.sql
    """
    And the exit status should be 0

  Scenario: We can explicitly avoid overwriting with --no-force
    Given an empty file named "big_client.sql"
    And a yaml configuration file that specifies that "force" is "true"
    When I run `db_backup.rb --no-force big_client`
    Then the stderr should contain:
    """
    error: big_client.sql exists, use --force to overwrite
    """
    And the exit status should not be 0

  Scenario: App creates a config file initially if there isn't one
    Given no configuration file
    When I run `db_backup.rb big_client`
    Then the output should match /^Initialized configuration file in/
    And the yaml configuration file should exist with defaults for all options
