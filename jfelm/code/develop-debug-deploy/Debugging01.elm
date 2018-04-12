-- START:modules
module Debugging exposing (main)

import Debug
import Html exposing (Html, text)
import Json.Decode exposing (Decoder, decodeString, int, string)
import Json.Decode.Pipeline exposing (decode, required)
-- END:modules


-- START:type.alias
type alias Dog =
    { name : String
    , age : Int
    }
-- END:type.alias


-- START:dogDecoder
dogDecoder : Decoder Dog
dogDecoder =
    decode Dog
        |> required "name" string
        |> required "age" int
-- END:dogDecoder


-- START:jsonDog
jsonDog : String
jsonDog =
    """
    {
      "name": "Tucker",
      "age": 11
    }
    """
-- END:jsonDog


-- START:decodedDog
decodedDog : Result String Dog
decodedDog =
    decodeString dogDecoder jsonDog
-- END:decodedDog


-- START:viewDog
viewDog : Dog -> Html msg
viewDog dog =
    text <|
        dog.name
            ++ " is "
            ++ toString dog.age
            ++ " years old."
-- END:viewDog


-- START:main
main : Html msg
main =
    case Debug.log "decodedDog" decodedDog of
        Ok dog ->
            viewDog dog

        Err _ ->
            text "ERROR: Couldn't decode dog."
-- END:main
