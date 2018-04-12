module SortFilter
    exposing
        ( Order(..)
        , Sort(..)
        , SortBy(..)
        , SortFilter
        , filterBreed
        , filterKind
        , filterSex
        , searchAnimals
        , setNameQuery
        , setSelectedBreed
        , setSelectedKind
        , setSelectedSex
        , setSort
        , sortAnimals
        , toggleOrder
        )

import Animal exposing (Animal)
import Animal.Kind as Kind exposing (Kind)
import Animal.Sex as Sex exposing (Sex)
import Regex exposing (regex)
import Select


type Order
    = Asc
    | Desc


type SortBy
    = SortByKind
    | SortByName
    | SortByBreed
    | SortBySex


type Sort
    = Sort SortBy Order


type alias SortFilter =
    { sort : Sort
    , nameQuery : String
    , selectedKind : Select.Selection Kind
    , selectedBreed : Select.Selection String
    , selectedSex : Select.Selection Sex
    }


toggleOrder : Order -> Order
toggleOrder order =
    case order of
        Asc ->
            Desc

        Desc ->
            Asc


setNameQuery : String -> SortFilter -> SortFilter
setNameQuery nameQuery sortFilter =
    { sortFilter | nameQuery = nameQuery }


setSort : Sort -> SortFilter -> SortFilter
setSort sort sortFilter =
    { sortFilter | sort = sort }


setSelectedKind : Select.Selection Kind -> SortFilter -> SortFilter
setSelectedKind selectedKind sortFilter =
    { sortFilter | selectedKind = selectedKind }


setSelectedBreed : Select.Selection String -> SortFilter -> SortFilter
setSelectedBreed selectedBreed sortFilter =
    { sortFilter | selectedBreed = selectedBreed }


setSelectedSex : Select.Selection Sex -> SortFilter -> SortFilter
setSelectedSex selectedSex sortFilter =
    { sortFilter | selectedSex = selectedSex }


serializeForSortBy : SortBy -> Animal -> String
serializeForSortBy sortBy =
    case sortBy of
        SortByKind ->
            .kind >> Kind.serialize

        SortByName ->
            .name

        SortByBreed ->
            .breed

        SortBySex ->
            .sex >> Sex.serialize


sortAnimalsDesc : (Animal -> String) -> Animal -> Animal -> Basics.Order
sortAnimalsDesc serialize animal1 animal2 =
    case compare (serialize animal1) (serialize animal2) of
        LT ->
            GT

        EQ ->
            EQ

        GT ->
            LT


sortAnimals : SortFilter -> List Animal -> List Animal
sortAnimals { sort } =
    let
        (Sort sortBy order) =
            sort

        serialize =
            serializeForSortBy sortBy
    in
    case order of
        Asc ->
            List.sortBy serialize

        Desc ->
            List.sortWith (sortAnimalsDesc serialize)


searchAnimals : SortFilter -> List Animal -> List Animal
searchAnimals { nameQuery } animals =
    let
        trimmedQuery =
            String.trim nameQuery

        queryRegex =
            trimmedQuery
                |> regex
                |> Regex.caseInsensitive
    in
    case trimmedQuery of
        "" ->
            animals

        _ ->
            List.filter
                (\animal -> Regex.contains queryRegex animal.name)
                animals


filterKind : SortFilter -> List Animal -> List Animal
filterKind { selectedKind } animals =
    Select.filterBy .kind selectedKind animals


filterBreed : SortFilter -> List Animal -> List Animal
filterBreed { selectedBreed } animals =
    Select.filterBy .breed selectedBreed animals


filterSex : SortFilter -> List Animal -> List Animal
filterSex { selectedSex } animals =
    Select.filterBy .sex selectedSex animals
