Feature: The executable has a good command-line interface
  As someone who wants to make a database backup
  The app has sufficient options to do that

  Scenario: Getting Help for GLI
    When I run `db_backup.rb --help`
    Then the output should contain:
    """
    Usage: db_backup [options]
        -i, --iteration
        -u USER
        -p PASSWORD
    """
  Scenario: Parsing all the command-line options
    When I run `db_backup.rb -i -u dave.c -p davec some_db DEBUG`
    Then the output should contain:
    """
    iteration: true
    user: dave.c
    password: davec
    some_db
    """
  Scenario: No command-line options
    When I run `db_backup.rb some_db DEBUG`
    Then the output should contain:
    """
    iteration: 
    user: 
    password: 
    some_db
    """
  Scenario: Bad username isn't accepted
    When I run `db_backup.rb -u foo some_db DEBUG`
    Then the output should contain:
    """
    invalid argument: -u foo
    Usage: db_backup [options]
        -i, --iteration
        -u USER
        -p PASSWORD
    """
