#START:feature
Feature: code-breaker submits guess

  The code-breaker submits a guess of four colored
  pegs. The game marks the guess with black and
  white "marker" pegs.

  For each peg in the guess that matches the color
  and position of a peg in the secret code, the
  mark includes one black peg. For each additional
  peg in the guess that matches the color but not
  the position of a peg in the secret code, a
  white peg is added to the mark.
#END:feature

#START:outline
  Scenario Outline: submit guess
    Given the secret code is "<code>"
    When I guess "<guess>"
    Then the mark should be "<mark>"
#END:outline

#START:first_scenarios
    Scenarios: all colors correct
      | code    | guess   | mark |
      | r g y c | r g y c | bbbb |
      | r g y c | r g c y | bbww |
      | r g y c | y r g c | bwww |
      | r g y c | c r g y | wwww |
#END:first_scenarios

