Codebreaker::Game
  #start
    sends a welcome message
    prompts for the first guess (FAILED - 1)

Failures:
  1) Codebreaker::Game#start prompts for the first guess
     Failure/Error: game.start
     Double "output" received :puts with unexpected arguments
       expected: ("Enter guess:")
            got: ("Welcome to Codebreaker!")
     # ./lib/codebreaker/game.rb:8:in `start'
     # ./spec/codebreaker/game_spec.rb:22

Finished in 0.00199 seconds
2 examples, 1 failure
