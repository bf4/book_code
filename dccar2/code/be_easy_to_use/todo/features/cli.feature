Feature: The executable has a good command-line interface
  As someone who wants to make a todo list app
  The app has sufficient options to do that

  Background:
    Given my terminal size is "80x24"

  Scenario: Verifying the scaffolding
    When I run `todo`
    Then the output should contain:
    """
    NAME
        todo - 

    SYNOPSIS
        todo [global options] command [command options] [arguments...]

    GLOBAL OPTIONS
        -f, --filename=arg - (default: none)
        --help             - Show this message
        -s                 - 

    COMMANDS
        done - 
        help - Shows a list of commands or help for one command
        list - 
        new  - 
    """

  Scenario: Verify that we take the options we want
    When I run `todo_integrated.rb`
    Then the output should contain:
    """
    NAME
        todo_integrated.rb - 

    SYNOPSIS
        todo_integrated.rb [global options] command [command options] [arguments...]

    VERSION
        0.0.1

    GLOBAL OPTIONS
        -f arg    - (default: none)
        --help    - Show this message
        --version - Display the program version

    COMMANDS
        done - 
        help - Shows a list of commands or help for one command
        list - 
        new  - 
    """

  Scenario: Verify that the new task takes the proper options
    When I run `todo_integrated.rb help new`
    Then the output should contain:
    """
    new [command options]
    """
    And the output should contain:
    """
    COMMAND OPTIONS
        -f             - 
        --priority=arg - (default: none)
    """
    When I run `todo_integrated.rb -f ~/todo.txt new -f --priority 4 "New Todo"`
    Then the output should contain:
    """
    Global:
    -f - ~/todo.txt
    Command:
    -f - true
    --priority - 4
    args - New Todo
    """
    When I run `todo_integrated.rb -f ~/todo.txt new --priority 4 "New Todo" "Another New Todo"`
    Then the output should contain:
    """
    Global:
    -f - ~/todo.txt
    Command:
    -f - false
    --priority - 4
    args - New Todo,Another New Todo
    """

  Scenario: Verify that the list task takes the proper options
    When I run `todo_integrated.rb help list`
    Then the output should contain:
    """
    list [command options]
    """
    And the output should contain:
    """
    COMMAND OPTIONS
        -s arg - (default: none)
    """
    When I run `todo_integrated.rb -f ~/todo.txt list -s name`
    Then the output should contain:
    """
    Global:
    -f - ~/todo.txt
    Command:
    -s - name
    """

  Scenario: Verify that the done task takes the proper options
    When I run `todo_integrated.rb help done`
    Then the output should contain:
    """
    done
    """
    When I run `todo_integrated.rb -f ~/todo.txt done`
    Then the output should contain:
    """
    Global:
    -f - ~/todo.txt
    """
