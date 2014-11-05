Codebreaker::Game
  #start
    sends a welcome message (FAILED - 1)
    prompts for the first guess (FAILED - 2)

Failures:
  1) Codebreaker::Game#start sends a welcome message
     Failure/Error: game.start
     Double "output" received :puts with unexpected arguments
       expected: ("Welcome to Codebreaker!")
            got: ("Enter guess:")
     # ./lib/codebreaker/game.rb:10:in `start'
     # ./spec/codebreaker/game_spec.rb:12
  2) Codebreaker::Game#start prompts for the first guess
     Failure/Error: game.start
     Double "output" received :puts with unexpected arguments
       expected: ("Enter guess:")
            got: ("Welcome to Codebreaker!")
     # ./lib/codebreaker/game.rb:8:in `start'
     # ./spec/codebreaker/game_spec.rb:21
	 
Finished in 0.00219 seconds
2 examples, 2 failures
