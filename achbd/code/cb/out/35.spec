1) Codebreaker::Game #guess with 1 number match and 1 exact match (in that order)
      sends a mark with '+-'
    Failure/Error: output.should_receive(:puts).with('+-')
    Double "output" received :puts with unexpected arguments
      expected: ("+-")
           got: ("-+")
    # ./spec/codebreaker/game_spec.rb:57
