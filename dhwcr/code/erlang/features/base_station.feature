Feature: Base station

  Scenario: Handoff
    Given a call on channel 140
    When the signal quality is better on channel 151
    Then the call should hand off to channel 151
