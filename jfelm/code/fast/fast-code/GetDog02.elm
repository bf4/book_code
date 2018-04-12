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


withDefaultLazy : (() -> a) -> Maybe a -> a
withDefaultLazy thunk maybe =
    case maybe of
        Just value -> value
        Nothing -> thunk ()


getDogLazy : Dict String Dog -> String -> List Trick -> ( Dog, Dict String Dog )
getDogLazy dogs name tricks =
    let
        dog =
            Dict.get name dogs
                |> withDefaultLazy (\() -> createDog name tricks)

        newDogs =
            Dict.insert name dog dogs
    in
    ( dog, newDogs )


-- START:getDogLazyInsertion
getDogLazyInsertion : Dict String Dog -> String -> List Trick -> ( Dog, Dict String Dog )
getDogLazyInsertion dogs name tricks =
    Dict.get name dogs
        |> Maybe.map (\dog -> ( dog, dogs ))
        |> withDefaultLazy
            (\() ->
                let
                    dog = createDog name tricks
                in
                ( dog, Dict.insert name dog dogs )
            )
-- END:getDogLazyInsertion


-- START:getDogCaseExpression
getDogCaseExpression : Dict String Dog -> String -> List Trick -> ( Dog, Dict String Dog )
getDogCaseExpression dogs name tricks =
    case Dict.get name dogs of
        Just dog ->
            ( dog, dogs )
        Nothing ->
            let
                dog = createDog name tricks
                newDogs = Dict.insert name dog dogs
            in
            ( dog, newDogs )
-- END:getDogCaseExpression


tricks : List Trick
tricks =
    [ Sit, RollOver, Speak, Fetch, Spin ]


dogs : Dict String Dog
dogs =
    Dict.fromList
        [ ( "Tucker", createDog "Tucker" tricks ) ]


dogExists : Benchmark
dogExists =
    describe "dog exists"
        [ Benchmark.compare "implementations"
            -- START:benchmarks
            "lazy creation and insertion"
            (\_ -> getDogLazyInsertion dogs "Tucker" tricks)
            "case expression"
            (\_ -> getDogCaseExpression dogs "Tucker" tricks)
            -- END:benchmarks
        ]


suite : Benchmark
suite =
    describe "getDog"
        [ dogExists ]


main : BenchmarkProgram
main =
    program suite
