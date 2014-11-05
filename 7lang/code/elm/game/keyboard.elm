
-- START:part1
import Mouse
import Keyboard

data KeyInput = KeyInput Bool Float
defaultKeyInput = KeyInput False 0.0
keyInput = lift2 KeyInput Keyboard.space
                          (lift toFloat Mouse.x)


main = lift asText keyInput
-- END:part1

