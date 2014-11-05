Feature: Stock vs. Stock

  @vcr
  Scenario: Compare two stocks
    When I compare GOOG and GRPN
    Then GOOG should win
