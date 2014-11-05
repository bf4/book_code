Feature: transfer from one hashmap to another
  As a programmer
  I want to transfer one object from one hashmap to another
  So that I can implement my algorithms

  Scenario: object exists in original hashmap
    Given my hashmap contains "foo" with value "bar"
    And my other hashmap is empty

    When I transfer "foo" from my hashmap to my other hashmap

    Then my other hashmap should contain "foo" with value "bar"
    And my hashmap should not contain "foo"

  Scenario: transferring an object back and forth
    Given my hashmap contains "foo" with value "bar"
    And my hashmap contains "baz" with value "quux"
    And my other hashmap is empty

    When I transfer "foo" from my hashmap to my other hashmap
    And I transfer "foo" from my other hashmap to my hashmap

    Then my hashmap should contain "foo" with value "bar"
    And my hashmap should contain "baz" with value "quux"
    And my other hashmap should be empty
