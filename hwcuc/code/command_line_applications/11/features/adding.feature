Feature: Adding

  Scenario: Add two numbers
    Given the input "2+2"
    When the calculator is run
    Then the output should be "4"

#START:focus
  Scenario: Add two numbers interactively
    When the calculator is run with no input
    And I enter the calculation "2+2"
    Then the output should be "4"
#END:focus
