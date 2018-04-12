module GetDog exposing (..)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Dict exposing (Dict)
import Set


-- START:types
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
-- END:types


-- START:uniqueBy
uniqueBy : (a -> comparable) -> List a -> List a
uniqueBy f list =
    List.foldr
        (\item ( existing, accum ) ->
            let
                comparableItem = f item
            in
            if Set.member comparableItem existing then
                ( existing, accum )
            else
                ( Set.insert comparableItem existing, item :: accum )
        )
        ( Set.empty, [] )
        list
        |> Tuple.second
-- END:uniqueBy


-- START:createDog
createDog : String -> List Trick -> Dog
createDog name tricks =
    Dog name (uniqueBy toString tricks)
-- END:createDog


-- START:getDog
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
-- END:getDog


-- START:withDefaultLazy
withDefaultLazy : (() -> a) -> Maybe a -> a
withDefaultLazy thunk maybe =
    case maybe of
        Just value -> value
        Nothing -> thunk ()
-- END:withDefaultLazy


getDogLazy : Dict String Dog -> String -> List Trick -> ( Dog, Dict String Dog )
getDogLazy dogs name tricks =
    let
        dog =
            Dict.get name dogs
                -- START:getDogLazy
                |> withDefaultLazy (\() -> createDog name tricks)
                -- END:getDogLazy

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


-- START:benchmark.dogExists
dogExists : Benchmark
dogExists =
    describe "dog exists"
        [ Benchmark.compare "implementations"
            "eager creation"
            (\_ -> getDog dogs "Tucker" tricks)
            "lazy creation"
            (\_ -> getDogLazy dogs "Tucker" tricks)
        ]
-- END:benchmark.dogExists


suite : Benchmark
suite =
    describe "getDog"
        [ dogExists ]


main : BenchmarkProgram
main =
    program suite
