module Main exposing (..)

import Animal exposing (Animal)
import Animal.Kind as Kind exposing (Kind)
import Animal.Sex as Sex exposing (Sex)
import Animals
import Html exposing (Html, button, div, h2, input, label, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, classList, disabled, type_, value)
import Html.Events exposing (onClick, onInput)
-- START:import.html.lazy
import Html.Lazy exposing (lazy, lazy2)
-- END:import.html.lazy
import Http
import Json.Decode as Json
import Select
import SortFilter exposing (Order(..), SortBy(..), SortFilter)


-- START:url
url : String
url =
    "http://programming-elm.com/animals/large"
-- END:url



---- MODEL ----


type alias Dimensions =
    { kinds : List Kind
    , sexes : List Sex
    }


-- START:state.and.model
type alias State =
    { animals : List Animal
    , selectedAnimal : Maybe Animal
    , sortFilter : SortFilter
    , dimensions : Dimensions
    }


type alias Model =
    Maybe State
-- END:state.and.model


initialModel : Model
initialModel =
    Nothing


initialState : List Animal -> State
initialState animals =
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
        { kinds = Kind.list
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


breedsForKind : List Animal -> Kind -> List String
breedsForKind animals kind =
    case kind of
        Kind.Dog ->
            Animals.dogBreeds animals

        Kind.Cat ->
            Animals.catBreeds animals


breedsForSelectedKind : List Animal -> Select.Selection Kind -> List String
breedsForSelectedKind animals selectedKind =
    case selectedKind of
        Select.All ->
            Animals.breeds animals

        Select.One kind ->
            breedsForKind animals kind


updateState : StateMsg -> State -> State
updateState msg state =
    case msg of
        UpdateQuery nameQuery ->
            mapSortFilter (SortFilter.setNameQuery nameQuery) state

        Sort sort ->
            mapSortFilter (SortFilter.setSort sort) state

        SelectKind selection ->
            mapSortFilter (SortFilter.setSelectedKind selection) state

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


-- START:update
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveAnimals (Ok animals) ->
            ( Just (initialState animals), Cmd.none )
        StateMsg stateMsg ->
            ( Maybe.map (updateState stateMsg) model, Cmd.none )
        ReceiveAnimals (Err _) ->
            Debug.crash "Error receiving animals"
-- END:update



---- VIEW ----


viewFormSection : String -> Html msg -> Html msg
viewFormSection labelText child =
    div [ class "form-section" ]
        [ label [] [ text (labelText ++ ":") ]
        , child
        ]


viewAnimalFilters : State -> Html StateMsg
viewAnimalFilters { animals, dimensions, sortFilter } =
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
                    , options = breedsForSelectedKind animals sortFilter.selectedKind
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


-- START:viewAnimalList
viewAnimalList : SortFilter -> List Animal -> Html StateMsg
viewAnimalList sortFilter animals =
-- END:viewAnimalList
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
        , viewAnimalFilters state
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
                        , options = breedsForKind state.animals animal.kind
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


-- START:viewState
viewState : State -> Html StateMsg
viewState state =
    div [ class "main" ]
        [ viewAnimals state
        , viewSelectedAnimal state
        ]
-- END:viewState


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
