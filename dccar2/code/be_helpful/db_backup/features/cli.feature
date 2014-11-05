Feature: The executable has a good command-line interface
  As someone who wants to make a database backup
  The app has sufficient options to do that

  Scenario: Checking that the options are documented
    When I run `db_backup.rb --help`
    Then the output should contain:
    """
    Backup one or more MySQL databases

    Usage: db_backup.rb [options] database_name

        -i, --iteration                  Indicate that this backup is an "iteration" backup
        -u USER                          Database username, in first.last format
        -p PASSWORD                      Database password
    """

  Scenario: Checking that the options are documented and we get an arg missing message
    When I run `db_backup.rb`
    Then the output should contain:
    """
    error: you must supply a database_name

    Backup one or more MySQL databases

    Usage: db_backup.rb [options] database_name

        -i, --iteration                  Indicate that this backup is an "iteration" backup
        -u USER                          Database username, in first.last format
        -p PASSWORD                      Database password
    """
