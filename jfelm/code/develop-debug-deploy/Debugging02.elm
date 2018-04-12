module Debugging exposing (main)

import Debug
import Html exposing (Html, text)
-- START:imports
import Json.Decode exposing (Decoder, andThen, decodeString, fail, int, string, succeed)
-- END:imports
import Json.Decode.Pipeline exposing (decode, required)


-- START:breed
type Breed
    = Sheltie
    | Poodle
-- END:breed


-- START:type.alias.Dog
type alias Dog =
    { name : String
    , age : Int
    , breed : Breed
    }
-- END:type.alias.Dog


-- START:decodeBreed
decodeBreed : String -> Decoder Breed
decodeBreed breed =
    case breed of
        "Sheltie" ->
            succeed Sheltie

        _ ->
            Debug.crash "TODO"
-- END:decodeBreed


dogDecoder : Decoder Dog
dogDecoder =
    decode Dog
        |> required "name" string
        |> required "age" int
        -- START:dogDecoder
        |> required "breed" (string |> andThen decodeBreed)
        -- END:dogDecoder


jsonDog : String
jsonDog =
    """
    -- START:jsonDog
    {
      "name": "Tucker",
      "age": 11,
      "breed": "Sheltie"
    }
    -- END:jsonDog
    """


decodedDog : Result String Dog
decodedDog =
    decodeString dogDecoder jsonDog


viewDog : Dog -> Html msg
viewDog dog =
    -- START:viewDog
    text <|
        dog.name
            ++ " the "
            ++ toString dog.breed
            ++ " is "
            ++ toString dog.age
            ++ " years old."
    -- END:viewDog


main : Html msg
main =
    -- START:main
    case decodedDog of
        Ok dog ->
            viewDog dog

        Err _ ->
            Debug.crash "Couldn't decode dog."
    -- END:main
