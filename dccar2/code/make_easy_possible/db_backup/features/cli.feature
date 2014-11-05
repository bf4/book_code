Feature: We have long-form options
  In order for our app to make things easy on all types of users,
  we want each option to have a long-form as well as a short-form.

  Scenario: We have short and long form options
    When I run `db_backup.rb --help`
    Then the output should contain:
    """
Backup one or more MySQL databases

Usage: db_backup.rb [options] database_name

        -i, --end-of-iteration           Indicate that this backup is an "iteration" backup
        -u, --username USER              Database username, in first.last format
        -p, --password PASSWORD          Database password
            --no-gzip                    Do not compress the backup file
            --[no-]force                 Overwrite existing files
    """

  Scenario: We don't overwrite files by default
    Given an empty file named "big_client.sql"
    When I run `db_backup.rb big_client`
    Then the exit status should not be 0
    And the stderr should contain:
    """
    error: big_client.sql exists, use --force to overwrite
    """

  Scenario: We can be forced to overwrite a file
    Given an empty file named "big_client.sql"
    When I run `db_backup.rb --force big_client`
    Then the stderr should contain:
    """
    Overwriting big_client.sql
    """
    And the exit status should be 0
