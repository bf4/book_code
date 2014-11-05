module LanguageHead where

import Window
import Keyboard
import Mouse

{-- Part 1: Model the user input ----------------------------------------------

What information do you need to represent all relevant user input?

Task: Redefine `UserInput` to include all of the information you need.
      Redefine `userInput` to be a signal that correctly models the user
      input as described by `UserInput`.

------------------------------------------------------------------------------}

type Input = { space:Bool, x:Int, delta:Time }






{-- Part 2: Model the game ----------------------------------------------------

What information do you need to represent the entire game?

Tasks: Redefine `GameState` to represent your particular game.
       Redefine `defaultGame` to represent your initial game state.

For example, if you want to represent many objects that just have a position,
your GameState might just be a list of coordinates and your default game might
be an empty list (no objects at the start):

    type GameState = { objects : [(Float,Float)] }
    defaultGame = { objects = [] }

------------------------------------------------------------------------------}

data State = Play | Pause
type Head = { x:Float, y:Float, vx:Float, vy:Float }
data Heads = List Head
type Player = { x:Float, score:Int }

type Game = { state:State, heads:Heads, player:Player }

defaultHead = {x=0.0, y=0.1, vx=0.5, vy=0.0}
defaultGame : Game
defaultGame = { state   = Pause,
                heads   = Empty, 
                player  = {x=0.0, score=0} }


{-- Part 3: Update the game ---------------------------------------------------

How does the game step from one state to another based on user input?

Task: redefine `stepGame` to use the UserInput and GameState
      you defined in parts 1 and 2. Maybe use some helper functions
      to break up the work, stepping smaller parts of the game.

------------------------------------------------------------------------------}

stepPlayer player state = 
  { player | score <- stepScore player state}
  
stepScore player state = 
  if state == Pause then player.score else player.score + 1
  
stepGame : Input -> Game -> Game
stepGame {space, x, delta} ({state, heads, player} as game) =
  { game | state <-  if | space            -> Play
                        | otherwise        -> state 
         , player <- stepPlayer player state
         , heads <- [defaultHead] }


{-- Part 4: Display the game --------------------------------------------------

How should the GameState be displayed to the user?

Task: redefine `display` to use the GameState you defined in part 2.

------------------------------------------------------------------------------}

display : (Int,Int) -> Game -> Element
display (w,h) gameState = asText gameState



{-- That's all folks! ---------------------------------------------------------

The following code puts it all together and shows it on screen.

------------------------------------------------------------------------------}

delta = inSeconds <~ fps 50

input = sampleOn delta (Input <~ Keyboard.space
                               ~ lift ((*) 1) Mouse.x
                               ~ delta)


gameState = foldp stepGame defaultGame input

main = lift2 display Window.dimensions gameState