
Codebreaker::Game
  #start
    sends a welcome message
    prompts for the first guess
  #guess
    with no matches
      sends a mark with ''
    with 1 number match
      sends a mark with '-'
    with 1 exact match
      sends a mark with '+' (FAILED - 1)
    with 2 number matches
      sends a mark with '--'
    with 1 number match and 1 exact match (in that order)
      sends a mark with '+-' (FAILED - 2)

1) Codebreaker::Game #guess with 1 exact match sends a mark with '+'
    Failure/Error: output.should_receive(:puts).with('+')
    Double "output" received :puts with unexpected arguments
      expected: ("+")
           got: ("+-")
    # ./spec/codebreaker/game_spec.rb:40

2) Codebreaker::Game #guess with 1 number match and 1 exact match (in that order)
      sends a mark with '+-'
    Failure/Error: output.should_receive(:puts).with('+-')
    Double "output" received :puts with unexpected arguments
      expected: ("+-")
           got: ("+--")
    # ./spec/codebreaker/game_spec.rb:56


Finished in 0.00237 seconds
7 examples, 2 failures
