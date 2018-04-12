module Animal.Sex exposing (Sex(..), decode, decodeFromString, display, list, serialize)

import Json.Decode as Json exposing (Decoder, fail, string, succeed)
import Utils


type Sex
    = Female
    | Male


list : List Sex
list =
    [ Female, Male ]


decodeFromString : String -> Decoder Sex
decodeFromString sex =
    case Utils.normalize sex of
        "female" ->
            succeed Female

        "male" ->
            succeed Male

        _ ->
            fail "Unknown animal sex"


decode : Decoder Sex
decode =
    Json.andThen decodeFromString string


serialize : Sex -> String
serialize sex =
    case sex of
        Female ->
            "female"

        Male ->
            "male"


display : Sex -> String
display =
    toString
