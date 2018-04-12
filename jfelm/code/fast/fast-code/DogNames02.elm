module DogNames exposing (..)

-- START:imports
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
-- END:imports


type Kind
    = Dog
    | Cat


type alias Animal =
    { name : String
    , kind : Kind
    }


dogNames : List Animal -> List String
dogNames animals =
    animals
        |> List.filter (\{ kind } -> kind == Dog)
        |> List.map .name


-- START:dogNamesFilterMap
dogNamesFilterMap : List Animal -> List String
dogNamesFilterMap animals =
    animals
        |> List.filterMap
            (\{ name, kind } ->
                if kind == Dog then
                    Just name
                else
                    Nothing
            )
-- END:dogNamesFilterMap


-- START:animals
animals : List Animal
animals =
    [ Animal "Tucker" Dog
    , Animal "Sally" Dog
    , Animal "Sassy" Cat
    , Animal "Turbo" Dog
    , Animal "Chloe" Cat
    ]
-- END:animals


suite : Benchmark
suite =
    -- START:benchmarks
    describe "dog names"
        [ benchmark "filter and map" <|
            \_ -> dogNames animals
        , benchmark "filterMap" <|
            \_ -> dogNamesFilterMap animals
        ]
    -- END:benchmarks


-- START:main
main : BenchmarkProgram
main =
    program suite
-- END:main
