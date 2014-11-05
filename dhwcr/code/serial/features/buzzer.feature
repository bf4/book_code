Feature: Buzzer

  Scenario Outline: Game
    Given a new game
    When the first buzz comes from <player>
    Then <led> should be lit

    Examples:
      | player       | led       |
      | player 1     | LED 1     |
      | player 2     | LED 2     |
      | both players | both LEDs |
