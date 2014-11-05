Feature: Do a complete system test

  Background:
    Given we're faking things out

  Scenario: End-to-end test using a real database
    Given the database backup_test exists
    When I successfully run `db_backup.rb --force --username root backup_test`
    Then db_backup.rb should've executed "mysqldump"
    And db_backup.rb should've executed "gzip"

  Scenario: End-to-end test using a real database, skipping gzip
    Given the database backup_test exists
    When I successfully run `db_backup.rb --force --username root --no-gzip backup_test`
    Then db_backup.rb should've executed "mysqldump"
    But db_backup.rb should NOT have executed "gzip"
