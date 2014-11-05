Codebreaker::Game
  #start
    sends a welcome message (FAILED - 1)
    prompts for the first guess (PENDING: Not Yet Implemented)

Pending:
  Codebreaker::Game#start prompts for the first guess
    # Not Yet Implemented
    # ./spec/codebreaker/game_spec.rb:17

Failures:
  1) Codebreaker::Game#start sends a welcome message
     Failure/Error: output.should_receive(:puts).with('Welcome to Codebreaker!')
     (Double "output").puts("Welcome to Codebreaker!")
         expected: 1 time
         received: 0 times
     # ./spec/codebreaker/game_spec.rb:11

Finished in 0.00143 seconds
2 examples, 1 failure, 1 pending
