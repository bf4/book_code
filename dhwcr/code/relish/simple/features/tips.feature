Feature: Tips and tricks

  This section contains general Cucumber techniques not tied to
  specific technologies or platforms.

  Scenario: Continuous integration

    A continuous integration server helps you catch regressions in
    your code by re-running your Cucumber examples whenever you push a
    new code change to the server.

    Given a continuous integration server
    When I push my code changes
    Then all my Cucumber features should run
