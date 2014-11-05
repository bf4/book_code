Feature: We can accept new items on the standard input

  Background:
    Given my terminal size is "80x24"
    And my home directory is in "/tmp"
    And an empty tasklist in "/tmp/todo.txt"

  Scenario: Create a new configuration file
    Given the file "/tmp/.todo.rc.yaml" doesn't exist
    Given I successfully run `todo --filename=/tmp/todo.txt new 'Some new todo item'`
    When I successfully run `todo --filename=/tmp/todo.txt initconfig`
    Then a file named "/tmp/.todo.rc.yaml" should exist
    When I successfully run `todo list`
    Then the stdout should contain "Some new todo item"
