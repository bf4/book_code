module GetDog exposing (..)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Dict exposing (Dict)
import Set


type Trick
    = Sit
    | RollOver
    | Speak
    | Fetch
    | Spin


type alias Dog =
    { name : String
    , tricks : List Trick
    }


uniqueBy : (a -> comparable) -> List a -> List a
uniqueBy f list =
    List.foldr
        (\item ( existing, accum ) ->
            let
                comparableItem =
                    f item
            in
            if Set.member comparableItem existing then
                ( existing, accum )
            else
                ( Set.insert comparableItem existing, item :: accum )
        )
        ( Set.empty, [] )
        list
        |> Tuple.second


createDog : String -> List Trick -> Dog
createDog name tricks =
    Dog name (uniqueBy toString tricks)


getDog : Dict String Dog -> String -> List Trick -> ( Dog, Dict String Dog )
getDog dogs name tricks =
    let
        dog =
            Dict.get name dogs
                |> Maybe.withDefault (createDog name tricks)

        newDogs =
            Dict.insert name dog dogs
    in
    ( dog, newDogs )


tricks : List Trick
tricks =
    [ Sit, RollOver, Speak, Fetch, Spin ]


dogs : Dict String Dog
dogs =
    Dict.fromList
        [ ( "Tucker", createDog "Tucker" tricks ) ]


dogExists : Benchmark
dogExists =
    describe "dog exists" []


suite : Benchmark
suite =
    describe "getDog"
        [ dogExists ]


main : BenchmarkProgram
main =
    program suite
