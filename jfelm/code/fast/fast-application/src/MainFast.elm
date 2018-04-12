module Main exposing (..)

import Animal exposing (Animal)
import Animal.Kind as Kind exposing (Kind)
import Animal.Sex as Sex exposing (Sex)
import Animals
import Html exposing (Html, button, div, h2, input, label, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, classList, disabled, type_, value)
import Html.Events exposing (onClick, onInput)
import Html.Lazy exposing (lazy, lazy2)
import Http
import Json.Decode as Json
import Select
import SortFilter exposing (Order(..), SortBy(..), SortFilter)


url : String
url =
    "http://programming-elm.com/animals"



---- MODEL ----


type alias Dimensions =
    { allBreeds : List String
    , dogBreeds : List String
    , catBreeds : List String
    , availableBreeds : List String
    , kinds : List Kind
    , sexes : List Sex
    }


type alias State =
    { animals : List Animal
    , selectedAnimal : Maybe Animal
    , sortFilter : SortFilter
    , dimensions : Dimensions
    }


type alias Model =
    Maybe State


initialModel : Model
initialModel =
    Nothing


initialState : List Animal -> State
initialState animals =
    let
        allBreeds =
            Animals.breeds animals

        ( dogBreeds, catBreeds ) =
            Animals.collectBreeds animals
    in
    { animals = animals
    , selectedAnimal = Nothing
    , sortFilter =
        { sort = SortFilter.Sort SortByName Asc
        , nameQuery = ""
        , selectedKind = Select.All
        , selectedBreed = Select.All
        , selectedSex = Select.All
        }
    , dimensions =
        { allBreeds = allBreeds
        , dogBreeds = dogBreeds
        , catBreeds = catBreeds
        , availableBreeds = allBreeds
        , kinds = Kind.list
        , sexes = Sex.list
        }
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Animals.fetch url ReceiveAnimals )



---- UPDATE ----


type StateMsg
    = UpdateQuery String
    | Sort SortFilter.Sort
    | SelectKind (Select.Selection Kind)
    | SelectBreed (Select.Selection String)
    | SelectSex (Select.Selection Sex)
    | UpdateSelectedAnimal Animal.Field
    | Edit Animal
    | SaveSelectedAnimal
    | CancelEdit


type Msg
    = ReceiveAnimals (Result Http.Error (List Animal))
    | StateMsg StateMsg


sortAndFilterAnimals : SortFilter -> List Animal -> List Animal
sortAndFilterAnimals sortFilter animals =
    animals
        |> SortFilter.sortAnimals sortFilter
        |> SortFilter.searchAnimals sortFilter
        |> SortFilter.filterKind sortFilter
        |> SortFilter.filterBreed sortFilter
        |> SortFilter.filterSex sortFilter


mapSortFilter : (SortFilter -> SortFilter) -> State -> State
mapSortFilter f state =
    { state | sortFilter = f state.sortFilter }


mapDimensions : (Dimensions -> Dimensions) -> State -> State
mapDimensions f state =
    { state | dimensions = f state.dimensions }


saveSelectedAnimal : State -> State
saveSelectedAnimal state =
    case state.selectedAnimal of
        Just selectedAnimal ->
            { state
                | animals = Animals.save selectedAnimal state.animals
                , selectedAnimal = Nothing
            }

        Nothing ->
            state


breedsForKind : Dimensions -> Kind -> List String
breedsForKind dimensions kind =
    case kind of
        Kind.Dog ->
            dimensions.dogBreeds

        Kind.Cat ->
            dimensions.catBreeds


breedsForSelectedKind : Dimensions -> Select.Selection Kind -> List String
breedsForSelectedKind dimensions selectedKind =
    case selectedKind of
        Select.All ->
            dimensions.allBreeds

        Select.One kind ->
            breedsForKind dimensions kind


updateSelectedKind : Select.Selection Kind -> State -> State
updateSelectedKind selectedKind ({ dimensions, sortFilter } as state) =
    let
        breeds =
            breedsForSelectedKind dimensions selectedKind

        selectedBreed =
            case sortFilter.selectedBreed of
                Select.All ->
                    Select.All

                Select.One breed ->
                    if List.member breed breeds then
                        Select.One breed
                    else
                        Select.All
    in
    state
        |> mapDimensions (\d -> { d | availableBreeds = breeds })
        |> mapSortFilter (SortFilter.setSelectedBreed selectedBreed)
        |> mapSortFilter (SortFilter.setSelectedKind selectedKind)


updateState : StateMsg -> State -> State
updateState msg state =
    case msg of
        UpdateQuery nameQuery ->
            mapSortFilter (SortFilter.setNameQuery nameQuery) state

        Sort sort ->
            mapSortFilter (SortFilter.setSort sort) state

        SelectKind selection ->
            updateSelectedKind selection state

        SelectBreed selection ->
            mapSortFilter (SortFilter.setSelectedBreed selection) state

        SelectSex selection ->
            mapSortFilter (SortFilter.setSelectedSex selection) state

        UpdateSelectedAnimal field ->
            { state | selectedAnimal = Maybe.map (Animal.update field) state.selectedAnimal }

        Edit animal ->
            { state | selectedAnimal = Just animal }

        SaveSelectedAnimal ->
            saveSelectedAnimal state

        CancelEdit ->
            { state | selectedAnimal = Nothing }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveAnimals (Ok animals) ->
            ( Just (initialState animals), Cmd.none )

        StateMsg stateMsg ->
            ( Maybe.map (updateState stateMsg) model, Cmd.none )

        ReceiveAnimals (Err _) ->
            Debug.crash "Error receiving animals"



---- VIEW ----


viewFormSection : String -> Html msg -> Html msg
viewFormSection labelText child =
    div [ class "form-section" ]
        [ label [] [ text (labelText ++ ":") ]
        , child
        ]


viewAnimalFilters : Dimensions -> SortFilter -> Html StateMsg
viewAnimalFilters dimensions sortFilter =
    div [ class "animal-filters" ]
        [ div []
            [ viewFormSection "Search Names" <|
                input
                    [ type_ "text"
                    , value sortFilter.nameQuery
                    , onInput UpdateQuery
                    ]
                    []
            , viewFormSection "Filter By Type" <|
                Select.viewWithAll
                    { serialize = Kind.serialize
                    , display = Kind.display
                    , decode = Kind.decodeFromString
                    , selection = sortFilter.selectedKind
                    , options = dimensions.kinds
                    , onSelect = SelectKind
                    }
            , viewFormSection "Filter By Breed" <|
                Select.viewWithAll
                    { serialize = identity
                    , display = identity
                    , decode = Json.succeed
                    , selection = sortFilter.selectedBreed
                    , options = dimensions.availableBreeds
                    , onSelect = SelectBreed
                    }
            , viewFormSection "Filter By Sex" <|
                Select.viewWithAll
                    { serialize = Sex.serialize
                    , display = Sex.display
                    , decode = Sex.decodeFromString
                    , selection = sortFilter.selectedSex
                    , options = dimensions.sexes
                    , onSelect = SelectSex
                    }
            ]
        ]


viewColumnHeader : SortBy -> String -> SortFilter.Sort -> Html StateMsg
viewColumnHeader sortBy title (SortFilter.Sort currentSortBy currentOrder) =
    let
        selectedSortBy =
            sortBy == currentSortBy

        ( newSortBy, newOrder ) =
            if selectedSortBy then
                ( currentSortBy, SortFilter.toggleOrder currentOrder )
            else
                ( sortBy, Asc )

        newSort =
            SortFilter.Sort newSortBy newOrder
    in
    th
        [ classList
            [ ( "asc", selectedSortBy && currentOrder == Asc )
            , ( "desc", selectedSortBy && currentOrder == Desc )
            ]
        , onClick (Sort newSort)
        ]
        [ text title ]


viewAnimal : Animal -> Html StateMsg
viewAnimal animal =
    tr []
        [ td [] [ text (Kind.display animal.kind) ]
        , td [] [ text animal.name ]
        , td [] [ text animal.breed ]
        , td [] [ text (Sex.display animal.sex) ]
        , td []
            [ button
                [ class "edit-button"
                , onClick (Edit animal)
                ]
                [ text "Edit" ]
            ]
        ]


viewAnimalList : SortFilter -> List Animal -> Html StateMsg
viewAnimalList sortFilter animals =
    let
        sortedAndFilteredAnimals =
            sortAndFilterAnimals sortFilter animals
    in
    table [ class "animals" ]
        [ thead []
            [ tr []
                [ viewColumnHeader SortByKind "Type" sortFilter.sort
                , viewColumnHeader SortByName "Name" sortFilter.sort
                , viewColumnHeader SortByBreed "Breed" sortFilter.sort
                , viewColumnHeader SortBySex "Sex" sortFilter.sort
                , th [] []
                ]
            ]
        , tbody [] (List.map (lazy viewAnimal) sortedAndFilteredAnimals)
        ]


viewAnimals : State -> Html StateMsg
viewAnimals state =
    div [ class "animals" ]
        [ h2 [] [ text "Rescue Me" ]
        , lazy2 viewAnimalFilters state.dimensions state.sortFilter
        , lazy2 viewAnimalList state.sortFilter state.animals
        ]


viewSelectedAnimal : State -> Html StateMsg
viewSelectedAnimal state =
    case state.selectedAnimal of
        Just animal ->
            div [ class "selected-animal" ]
                [ h2 [] [ text ("Selected " ++ Kind.display animal.kind)]
                , viewFormSection "Name" <|
                    input
                        [ type_ "text"
                        , value animal.name
                        , onInput (UpdateSelectedAnimal << Animal.Name)
                        ]
                        []
                , viewFormSection "Breed" <|
                    Select.view
                        { serialize = identity
                        , display = identity
                        , decode = Json.succeed
                        , selection = animal.breed
                        , options = breedsForKind state.dimensions animal.kind
                        , onSelect = UpdateSelectedAnimal << Animal.Breed
                        }
                , viewFormSection "Sex" <|
                    Select.view
                        { serialize = Sex.serialize
                        , display = Sex.display
                        , decode = Sex.decodeFromString
                        , selection = animal.sex
                        , options = state.dimensions.sexes
                        , onSelect = UpdateSelectedAnimal << Animal.Sex
                        }
                , div [ class "actions" ]
                    [ button
                        [ class "save-button"
                        , disabled (String.trim animal.name == "")
                        , onClick SaveSelectedAnimal
                        ]
                        [ text "Save" ]
                    , button
                        [ class "cancel-button"
                        , onClick CancelEdit
                        ]
                        [ text "Cancel" ]
                    ]
                ]

        Nothing ->
            text ""


viewState : State -> Html StateMsg
viewState state =
    div [ class "main" ]
        [ viewAnimals state
        , viewSelectedAnimal state
        ]


view : Model -> Html Msg
view model =
    case model of
        Nothing ->
            div [] [ text "Loading..." ]

        Just state ->
            viewState state
                |> Html.map StateMsg



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
