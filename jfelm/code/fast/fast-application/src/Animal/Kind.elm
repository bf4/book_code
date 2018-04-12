module Animal.Kind exposing (Kind(..), decode, decodeFromString, display, list, serialize)

import Json.Decode as Json exposing (Decoder, fail, string, succeed)
import Utils


type Kind
    = Dog
    | Cat


list : List Kind
list =
    [ Dog, Cat ]


decodeFromString : String -> Decoder Kind
decodeFromString kind =
    case Utils.normalize kind of
        "dog" ->
            succeed Dog

        "cat" ->
            succeed Cat

        _ ->
            fail "Unknown animal kind"


decode : Decoder Kind
decode =
    Json.andThen decodeFromString string


serialize : Kind -> String
serialize kind =
    case kind of
        Dog ->
            "dog"

        Cat ->
            "cat"


display : Kind -> String
display =
    toString
