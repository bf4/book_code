Feature: We can accept new items on the standard input

  Background:
    Given my terminal size is "80x24"
    And an empty tasklist in "/tmp/todo.txt"

  Scenario: Create new tasks via stdin
    When I run `todo --filename=/tmp/todo.txt new` interactively
    And I type "Rake Leaves"
    And I type "Take Out Trash"
    And I type "Wash Car"
    And I run `todo --filename=/tmp/todo.txt list`
    #And the output should contain:
    #"""
    # 1 - Rake Leaves
    #"""
    #And the output should contain:
    #"""
    # 2 - Take Out Trash
    #"""
    #And the output should contain:
    #"""
    # 3 - Wash Car
    #"""
  Scenario: Create no new tasks via stdin
    #  When I run `todo --filename=/tmp/todo.txt new` interactively
    #And I type ""
    #Then the exit status should not be 0

  Scenario: Output format is pretty by default for tty
    Given an existing tasklist in "/tmp/todo.txt"
    When I run `todo --force-tty --filename=/tmp/todo.txt list`
    Then the output should contain:
    """
     1 - Rake Leaves
         Created:   2011-08-13 12:00:00 -0400
     2 - Take Out Trash
         Created:   2011-08-19 13:00:00 -0400
    """
  Scenario: Output format is non-pretty by default for a redirect
    Given an existing tasklist in "/tmp/todo.txt"
    When I run `todo --filename=/tmp/todo.txt list | cat`
    Then the output should contain:
    """
    1,Rake Leaves,U,2011-08-13 12:00:00 -0400,
    2,Take Out Trash,U,2011-08-19 13:00:00 -0400,
    """
