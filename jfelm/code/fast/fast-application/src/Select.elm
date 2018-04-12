module Select exposing (Selection(..), filterBy, view, viewWithAll)

import Html exposing (Html, option, select, text)
import Html.Attributes exposing (selected, value)
import Html.Events exposing (on, targetValue)
import Json.Decode as Json exposing (Decoder)
import Regex exposing (regex)


type Selection a
    = All
    | One a


type IncludeAll
    = IncludeAll
    | NoAll


type alias SelectOneOrAllConfig a msg =
    { serialize : a -> String
    , display : a -> String
    , decode : String -> Decoder a
    , selection : Selection a
    , options : List a
    , onSelect : Selection a -> msg
    }


type alias SelectOneConfig a msg =
    { serialize : a -> String
    , display : a -> String
    , decode : String -> Decoder a
    , selection : a
    , options : List a
    , onSelect : a -> msg
    }


filterBy : (a -> b) -> Selection b -> List a -> List a
filterBy attribute selection values =
    case selection of
        All ->
            values

        One selectedValue ->
            List.filter (\value -> attribute value == selectedValue) values


viewOptions : (Selection a -> String) -> (a -> String) -> Selection a -> List a -> List (Html msg)
viewOptions serialize display selection options =
    List.map
        (\optionValue ->
            option
                [ selected (selection == One optionValue)
                , value (serialize (One optionValue))
                ]
                [ text (display optionValue) ]
        )
        options


viewAllOption : (Selection a -> String) -> Selection a -> Html msg
viewAllOption serialize selection =
    option
        [ selected (selection == All)
        , value (serialize All)
        ]
        [ text "All" ]


viewHelp : IncludeAll -> SelectOneOrAllConfig a msg -> Html msg
viewHelp includeAll config =
    let
        serialize =
            serializeSelection config.serialize

        options =
            viewOptions serialize config.display config.selection config.options
    in
    select [ onSelect (decodeSelection config.decode) config.onSelect ] <|
        case includeAll of
            IncludeAll ->
                viewAllOption serialize config.selection :: options

            NoAll ->
                options


viewWithAll : SelectOneOrAllConfig a msg -> Html msg
viewWithAll =
    viewHelp IncludeAll


view : SelectOneConfig a msg -> Html msg
view config =
    viewHelp NoAll
        { serialize = config.serialize
        , display = config.display
        , decode = config.decode
        , selection = One config.selection
        , options = config.options
        , onSelect = config.onSelect << unsafeUnwrap
        }


decodeSelection : (String -> Decoder a) -> String -> Decoder (Selection a)
decodeSelection decodeInner selection =
    let
        oneRegex =
            regex "^one\\((.*)\\)$"
    in
    case selection of
        "all" ->
            Json.succeed All

        _ ->
            let
                parsed =
                    selection
                        |> Regex.find Regex.All oneRegex
                        |> List.concatMap .submatches
            in
            case parsed of
                (Just inner) :: [] ->
                    inner
                        |> decodeInner
                        |> Json.map One

                _ ->
                    Json.fail "Unknown selection"


serializeSelection : (a -> String) -> Selection a -> String
serializeSelection serializeInner selection =
    case selection of
        All ->
            "all"

        One value ->
            "one(" ++ serializeInner value ++ ")"


onSelect : (String -> Decoder (Selection a)) -> (Selection a -> msg) -> Html.Attribute msg
onSelect decode tagger =
    let
        decoder =
            targetValue
                |> Json.andThen decode
                |> Json.map tagger
    in
    on "input" decoder


unsafeUnwrap : Selection a -> a
unsafeUnwrap selection =
    case selection of
        One value ->
            value

        All ->
            Debug.crash "Can't unwrap All"
