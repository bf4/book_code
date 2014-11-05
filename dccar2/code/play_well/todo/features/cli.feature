Feature: The executable has a good command-line interface
  As someone who wants to make a todo list app
  The app has sufficient options to do that

  Background:
    Given my terminal size is "80x24"
    And the following tasklist:
    """
    Clean kitchen,2011-06-03 13:45
    Rake leaves,2011-06-03 17:31,2011-06-03 18:34
    Take out garbage,2011-06-02 15:48
    Clean bathroom,2011-06-01 12:00
    """

  Scenario: List our tasks in pretty format
    And I run `todo --filename=/tmp/todo.txt list`
    Then the output should contain:
    """
     1 - Clean kitchen
         Created:   2011-06-03 13:45
     2 - Rake leaves
         Created:   2011-06-03 17:31
         Completed: 2011-06-03 18:34
     3 - Take out garbage
         Created:   2011-06-02 15:48
     4 - Clean bathroom
         Created:   2011-06-01 12:00
    """
  Scenario: List our tasks in UNIX format
    When I run `todo --filename=/tmp/todo.txt list --format=csv`
    Then the output should contain:
    """
    1,Clean kitchen,U,2011-06-03 13:45,
    2,Rake leaves,C,2011-06-03 17:31,2011-06-03 18:34
    3,Take out garbage,U,2011-06-02 15:48,
    4,Clean bathroom,U,2011-06-01 12:00,
    """
  Scenario: Auto-detect the format
    When I run `todo --filename=/tmp/todo.txt list --auto-detect`
    Then the output should contain:
    """
    1,Clean kitchen,U,2011-06-03 13:45,
    2,Rake leaves,C,2011-06-03 17:31,2011-06-03 18:34
    3,Take out garbage,U,2011-06-02 15:48,
    4,Clean bathroom,U,2011-06-01 12:00,
    """
