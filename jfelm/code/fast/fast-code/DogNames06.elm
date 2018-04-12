module DogNames exposing (..)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


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


-- START:dogNamesFoldl
dogNamesFoldl : List Animal -> List String
dogNamesFoldl animals =
    animals
        |> List.foldl
            (\{ name, kind } accum ->
                if kind == Dog then
                    accum ++ [ name ]
                else
                    accum
            )
            []
-- END:dogNamesFoldl


animals : List Animal
animals =
    [ Animal "Tucker" Dog
    , Animal "Sally" Dog
    , Animal "Sassy" Cat
    , Animal "Turbo" Dog
    , Animal "Chloe" Cat
    ]
        |> List.repeat 10
        |> List.concat


suite : Benchmark
suite =
    describe "dog names"
        [ Benchmark.compare "implementations"
            "filter and map"
            (\_ -> dogNames animals)
            -- START:benchmark.dogNamesFoldl
            "foldl"
            (\_ -> dogNamesFoldl animals)
            -- END:benchmark.dogNamesFoldl
        ]


main : BenchmarkProgram
main =
    program suite
