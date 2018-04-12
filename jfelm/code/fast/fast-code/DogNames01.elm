module DogNames exposing (..)


-- START:types
type Kind
    = Dog
    | Cat


type alias Animal =
    { name : String
    , kind : Kind
    }
-- END:types


-- START:dogNames
dogNames : List Animal -> List String
dogNames animals =
    animals
        |> List.filter (\{ kind } -> kind == Dog)
        |> List.map .name
-- END:dogNames
