Feature: Conversion

As a busy person
I want get answers in a standard format
So that I don't have to convert units in my head

  Scenario Outline: Converting times

  Given a calculator
  When I start with a time of <d>:<h>:<m>:<s>
  And I add 00:00:00:00
  Then the time should be <d_>:<h_>:<m_>:<s_>

  Examples:
    | d | h  | m  | s                   | d_              | h_ | m_ | s_ |
    | 1 | 47 | 59 | 59                  | 2               | 23 | 59 | 59 |
    | 1 | 47 | 59 | 60                  | 3               | 0  | 0  | 0  |
    | 1 | 47 | 59 | 61                  | 3               | 0  | 0  | 1  |
    | 0 | 0  | 0  | 86399               | 0               | 23 | 59 | 59 |
    | 0 | 0  | 0  | 86400               | 1               | 0  | 0  | 0  |
    | 0 | 0  | 0  | 86401               | 1               | 0  | 0  | 1  |
    | 0 | 0  | 0  | 9223372036854775807 | 106751991167300 | 15 | 30 | 7  |
