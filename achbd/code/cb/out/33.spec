1) Codebreaker::Game #guess with 2 number matches sends a mark with '--'
    Failure/Error: output.should_receive(:puts).with('--')
    Double "output" received :puts with unexpected arguments
      expected: ("--")
           got: ("-")
    # ./spec/codebreaker/game_spec.rb:49
