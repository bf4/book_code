module Main exposing (main)

import Html exposing (text)


greeting : String
greeting =
    "Hello, Static Elm!"


sayHello : String -> String
sayHello name =
    "Hello, " ++ name ++ "."


-- START:bottlesOf.annotation
bottlesOf : String -> Int -> String
-- END:bottlesOf.annotation
-- START:bottlesOf.definition
bottlesOf contents amount =
    toString amount ++ " bottles of " ++ contents ++ " on the wall."
-- END:bottlesOf.definition


-- START:main
main =
    text (bottlesOf "juice" 99)
-- END:main
