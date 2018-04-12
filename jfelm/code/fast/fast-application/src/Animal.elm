module Animal exposing (Animal, Field(..), Id, decode, update)

import Animal.Kind as Kind exposing (Kind)
import Animal.Sex as Sex exposing (Sex)
import Json.Decode exposing (Decoder, string, succeed)
import Json.Decode.Pipeline exposing (required)


type alias Id =
    String


type Field
    = Name String
    | Breed String
    | Sex Sex


type alias Animal =
    { id : Id
    , kind : Kind
    , name : String
    , breed : String
    , sex : Sex
    }


decode : Decoder Animal
decode =
    succeed Animal
        |> required "id" string
        |> required "type" Kind.decode
        |> required "name" string
        |> required "breed" string
        |> required "sex" Sex.decode


update : Field -> Animal -> Animal
update field animal =
    case field of
        Name name ->
            { animal | name = name }

        Breed breed ->
            { animal | breed = breed }

        Sex sex ->
            { animal | sex = sex }
