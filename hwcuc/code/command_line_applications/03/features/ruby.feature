Feature: ruby -e
  Scenario: print something
    When I run `ruby -e "puts 'hello'"`
    Then it should fail with:
      """
      hello
      """
