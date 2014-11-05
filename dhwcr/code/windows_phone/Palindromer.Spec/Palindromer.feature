Feature: Palindromer

  Scenario: Make a palindrome
    Given my app is clean installed and running
    When I type the word "tattarrattat"
    Then it should be recognized as a palindrome
