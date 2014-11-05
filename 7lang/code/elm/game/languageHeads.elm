-- START:part1
module LanguageHead where 

import Keyboard
import Mouse
import Random
-- END:part1

-- START:part2
data State = Play | Pause | GameOver  -- (1)

type Input = { space:Bool, x:Int, delta:Time, rand:Int }
type Head = { x:Float, y:Float, vx:Float, vy:Float }
type Player = { x:Float, score:Int }
type Game = { state:State, heads:[Head], player:Player }

defaultHead n = {x=100.0, y=75, vx=60, vy=0.0, img=headImage n }  -- (2)
defaultGame = { state   = Pause,
                heads   = [], 
                player  = {x=0.0, score=0} }
headImage n = 
  if | n == 0 -> "/img/brucetate.png"
     | n == 1 -> "/img/davethomas.png"
     | n == 2 -> "/img/evanczaplicki.png"
     | n == 3 -> "/img/joearmstrong.png"
     | n == 4 -> "/img/josevalim.png"
     | otherwise -> ""
bottom = 550
-- END:part2

-- START:part3
secsPerFrame = 1.0 / 50.0  
delta = inSeconds <~ fps 50

input = sampleOn delta (Input <~ Keyboard.space
                               ~ Mouse.x
                               ~ delta
                               ~ Random.range 0 4 (every secsPerFrame))

main = lift display gameState

gameState = foldp stepGame defaultGame input
-- END:part3

-- START:part4a
stepGame input game =             -- (3)
  case game.state of
    Play -> stepGamePlay input game
    Pause -> stepGamePaused input game
    GameOver -> stepGameFinished input game
    
stepGamePlay {space, x, delta, rand} ({state, heads, player} as game) =  -- (4)
  { game | state <-  stepGameOver x heads
         , heads <- stepHeads heads delta x player.score rand
         , player <- stepPlayer player x heads }

stepGameOver x heads = 
  if allHeadsSafe (toFloat x) heads then Play else GameOver
  
allHeadsSafe x heads =
    all (headSafe x) heads

headSafe x head =
    head.y < bottom || abs (head.x - x) < 50
-- END:part4a

-- START:part4b
stepHeads heads delta x score rand =    -- (5)
  spawnHead score heads rand 
  |> bounceHeads
  |> removeComplete
  |> moveHeads delta
  
spawnHead score heads rand =   -- (6)
  let addHead = length heads < (score `div` 5000 + 1) 
    && all (\head -> head.x > 107.0) heads in 
  if addHead then defaultHead rand :: heads else heads

bounceHeads heads = map bounce heads      -- (7)

bounce head = 
  { head | vy <- if head.y > bottom && head.vy > 0 
                 then -head.vy * 0.95 
                 else head.vy }

removeComplete heads = filter (\x -> not (complete x)) heads  -- (8)

complete {x} = x > 750

moveHeads delta heads = map moveHead heads     -- (9)

moveHead ({x, y, vx, vy} as head) = 
  { head | x <- x + vx * secsPerFrame
         , y <- y + vy * secsPerFrame
         , vy <- vy + secsPerFrame * 400 }

-- END:part4b

-- START:part4c
stepPlayer player mouseX heads =     -- (10)
  { player | score <- stepScore player heads
           , x <- toFloat mouseX }
           
stepScore player heads =   -- (11)
  player.score + 
  1 + 
  1000 * (length (filter complete heads))
-- END:part4c

-- START:part4d
stepGamePaused {space, x, delta} ({state, heads, player} as game) =    -- (12)
  { game | state <- stepState space state
         , player <- { player |  x <- toFloat x } }    

stepGameFinished {space, x, delta} ({state, heads, player} as game) =   -- (13)
  if space then defaultGame    
  else { game | state <- GameOver
              , player <- { player |  x <- toFloat x } }

stepState space state = if space then Play else state   -- (14)
-- END:part4d

-- START:part5
display ({state, heads, player} as game) =   -- (15)
  let (w, h) = (800, 600)
  in collage w h
       ([ drawRoad w h
       , drawBuilding w h
       , drawPaddle w h player.x
       , drawScore w h player
       , drawMessage w h state] ++ 
       (drawHeads w h heads))

drawRoad w h =   -- (16)
  filled gray (rect (toFloat w) 100) 
  |> moveY (-(half h) + 50)
  
drawBuilding w h =
  filled red (rect 100 (toFloat h)) 
  |> moveX (-(half w) + 50)

drawHeads w h heads = map (drawHead w h) heads   -- (17)

drawHead w h head = 
  let x = half w - head.x
      y = half h - head.y
      src = head.img
  in toForm (image 75 75 src) 
     |> move (-x, y)
     |> rotate (degrees (x * 2 - 100))

drawPaddle w h x =   -- (18)
  filled black (rect 80 10) 
  |> moveX (x +  10 -  half w) 
  |> moveY (-(half h - 30))

half x = toFloat x / 2

drawScore w h player =     -- (19)
  toForm (fullScore player) 
  |> move (half w - 150, half h - 40)

fullScore player = txt (Text.height 50) (show player.score)

txt f = text . f . monospace . Text.color blue . toText

drawMessage w h state =    -- (20)
  toForm (txt (Text.height 50) (stateMessage state)) 
  |> move (50, 50)
  
stateMessage state = 
  if state == GameOver then "Game Over" else "Language Head"
-- END:part5
