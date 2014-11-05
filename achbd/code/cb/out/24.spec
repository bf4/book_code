1) Codebreaker::Game #guess with no matches sends a mark with ''
    Failure/Error: output.should_receive(:puts).with('')
    (Double "output").puts("")
        expected: 1 time
        received: 0 times
    # ./spec/codebreaker/game_spec.rb:27
