Feature: Seconds

As a time-conscious person
I want to count seconds
So that each second will count

  Scenario: Adding seconds

  Given a calculator
  And the following addition table:
    | +    | 0    | 1     | 2    | huge |
    | 0    | 0    | -     | -    | -    |
    | 1    | 1    | 2     | -    | -    |
    | 2    | 2    | 3     | 4    | -    |
    | huge | huge | huger | over | over |
  Then each pair of numbers should add to the given value
