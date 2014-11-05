Feature: The executable has a good command-line interface
  As someone who wants to make a todo list app
  The app has sufficient options to do that

  Background:
    Given my terminal size is "80x24"

  Scenario: Verify general help output 
    When I run `todo help`
    Then the output should contain:
    """
    NAME
        todo - 

    SYNOPSIS
        todo [global options] command [command options] [arguments...]

    GLOBAL OPTIONS
        -f, --filename=todo_file - Path to the todo file (default: ~/.todo.txt)
        --help                   - Show this message

    COMMANDS
        done - Complete a task
        help - Shows a list of commands or help for one command
        list - List tasks
        new  - Create a new task in the task list
    """

  Scenario: Verify help output of new command
    When I run `todo help new`
    Then the output should contain:
    """
    NAME
        new - Create a new task in the task list

    SYNOPSIS
        todo [global options] new [command options] task_name

    DESCRIPTION
        A task has a name and a priority. By default, new tasks have the lowest
        possible priority, though this can be overridden. 

    COMMAND OPTIONS
        -f          - put the new task first in the list
        -p priority - set the priority of the new task, 1 being the highest
                      (default: none)
    """
