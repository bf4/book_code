Feature: Fruit list
  In order to make a great smoothie
  I need some fruit.
  
  Scenario: List fruit
    Given the system knows about the following fruit:
      | name       | color  |
      | banana     | yellow |
      | strawberry | red    |
    When the client requests GET /fruits
    Then the response should be JSON:
      """
      [
        {"name": "banana", "color": "yellow"},
        {"name": "strawberry", "color": "red"}
      ]
      """
