module LanguageHead where

import Window
import Keyboard
import Mouse

type Input = { space:Bool, x:Int, delta:Time }

data State = Play | Pause
type Head = { x:Float, y:Float, vx:Float, vy:Float }
type Heads = [Head]
type Player = { x:Float, score:Int }

type Game = { state:State, heads:Heads, player:Player }

defaultHead = {x=0.0, y=50, vx=250, vy=0.0}
defaultHeads = [defaultHead]
defaultGame : Game
defaultGame = { state   = Pause,
                heads   = [], 
                player  = {x=0.0, score=0} }

stepState space state = if space then Play else state

stepPlayer player mouseX heads = 
  { player | score <- stepScore player heads
           , x <- toFloat mouseX }
           
stepScore player heads = 
  player.score + 1
  
stepHeads heads delta = 
  ensureHead heads |> 
  bounceHeads |>
  removeComplete |> 
  moveHeads delta
  
removeComplete heads = filter (\x -> not (complete x)) heads

complete : Head -> Bool
complete {x} = x > 750

ensureHead heads = 
  if heads == [] then [defaultHead] 
                 else heads

bounceHeads heads = map bounce heads

bounce head = 
  { head | vy <- if head.y > 550 then -head.vy * 0.9 else head.vy}

moveHeads delta heads = map moveHead heads

moveHead ({x, y, vx, vy} as head) = 
  { head | x <- x + vx * framesPerSec
         , y <- y + vy * framesPerSec
         , vy <- vy + framesPerSec * 500 }
headY head = head

stepGamePlay : Input -> Game -> Game
stepGamePlay {space, x, delta} ({state, heads, player} as game) =
  { game | state <-  stepState space state
         , heads <- stepHeads heads delta
         , player <- stepPlayer player x heads }



stepPlayerPaused player mouseX = 
  { player |  x <- toFloat mouseX }

stepGamePaused : Input -> Game -> Game
stepGamePaused {space, x, delta} ({state, heads, player} as game) =
  { game | state <- stepState space state
         , player <- stepPlayerPaused player x }    


stepGame : Input -> Game -> Game
stepGame ({space, x, delta} as input) ({state, heads, player} as game) =
  if state == Play then stepGamePlay input game 
                   else stepGamePaused input game

display : (Int,Int) -> Game -> Element
display (w,h) gameState = asText gameState

framesPerSec = 1.0 / 50.0
delta = inSeconds <~ fps 50

input = sampleOn delta (Input <~ Keyboard.space
                               ~ lift ((*) 1) Mouse.x
                               ~ delta)


gameState = foldp stepGame defaultGame input

main = lift2 display Window.dimensions gameState