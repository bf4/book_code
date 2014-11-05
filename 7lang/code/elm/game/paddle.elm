import Mouse
import Window

drawPaddle w h x = 
  filled black (rect 80 10)         |> 
  moveX (toFloat x - toFloat w / 2) |> 
  moveY (-(toFloat h * 0.45))
                    
display (w, h) x  = collage w h
       [ drawPaddle w h x ]


main = lift2 display Window.dimensions Mouse.x

