module Debugging exposing (main)

import Html exposing (Html, text)
import Json.Decode exposing (Decoder, andThen, decodeString, fail, int, string, succeed)
import Json.Decode.Pipeline exposing (decode, required)


-- START:breed
type Breed
    = Sheltie
    | Poodle
    | Beagle
-- END:breed


type alias Dog =
    { name : String
    , age : Int
    , breed : Breed
    }


decodeBreed : String -> Decoder Breed
decodeBreed breed =
    -- START:decodeBreed
    case String.toLower breed of
        "sheltie" ->
            succeed Sheltie
        "poodle" ->
            succeed Poodle
        "beagle" ->
            succeed Beagle
        _ ->
            fail "Unknown breed"
    -- END:decodeBreed


dogDecoder : Decoder Dog
dogDecoder =
    decode Dog
        |> required "name" string
        |> required "age" int
        |> required "breed" (string |> andThen decodeBreed)


jsonDog : String
jsonDog =
    """
    {
      "name": "Tucker",
      "age": 11,
      "breed": "Sheltie"
    }
    """


decodedDog : Result String Dog
decodedDog =
    decodeString dogDecoder jsonDog


viewDog : Dog -> Html msg
viewDog dog =
    text <|
        dog.name
            ++ " the "
            ++ toString dog.breed
            ++ " is "
            ++ toString dog.age
            ++ " years old."


main : Html msg
main =
    case decodedDog of
        Ok dog ->
            viewDog dog

        -- START:main
        Err _ ->
            text "ERROR: Couldn't decode dog."
        -- END:main
