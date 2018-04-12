module Main exposing (main)

import Html exposing (text)


greeting : String
greeting =
    "Hello, Static Elm!"


-- START:sayHello
sayHello : String -> String
sayHello name =
    "Hello, " ++ name ++ "."
-- END:sayHello


-- START:main
main =
    text (sayHello "Functional Elm")
-- END:main
