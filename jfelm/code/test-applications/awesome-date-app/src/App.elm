module App exposing (DateOffsetField(..), Flags, Model, Msg(..), init, update, view)

import AwesomeDate as Date exposing (Date)
import Html exposing (Html, div, h1, hr, input, label, span, table, td, text, th, tr)
import Html.Attributes exposing (class, id, pattern, type_, value)
import Html.Events exposing (onInput)


---- MODEL ----


type alias Flags =
    { year : Int
    , month : Int
    , day : Int
    }


-- START:type.alias.Model
type alias Model =
    { selectedDate : Date
    , years : Maybe Int
    , months : Maybe Int
    , days : Maybe Int
    }
-- END:type.alias.Model


initialModel : Flags -> Model
initialModel { year, month, day } =
    { selectedDate = Date.create year month day
    , years = Just 0
    , months = Just 0
    , days = Just 0
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel flags, Cmd.none )



---- VIEW ----


viewDateInput : (Maybe Date -> msg) -> Date -> Html msg
viewDateInput onChange date =
    input
        [ type_ "date"
        , value (Date.toISO8601 date)
        , onInput (onChange << Date.fromISO8601)
        ]
        []


viewTableRow : String -> String -> String -> Html msg
viewTableRow identifier label value =
    tr [ id identifier ]
        [ th [] [ text label ]
        , td [] [ text value ]
        ]


viewDateInfo : Date -> Html msg
viewDateInfo date =
    let
        year =
            Date.year date

        daysInMonth =
            Date.daysInMonth year (Date.month date)

        isLeapYear =
            if Date.isLeapYear year then
                "Yes"
            else
                "No"
    in
    table []
        [ viewTableRow "info-weekday" "Weekday" (toString <| Date.weekday date)
        , viewTableRow "info-days" "Days in Month" (toString daysInMonth)
        , viewTableRow "info-leap-year" "Leap Year?" isLeapYear
        ]


toInt : String -> Result String (Maybe Int)
toInt input =
    case String.trim input of
        "" ->
            Ok Nothing

        trimmedInput ->
            trimmedInput
                |> String.toInt
                |> Result.map Just


viewPickDate : Date -> Html Msg
viewPickDate date =
    div [ class "pick-date" ]
        [ h1 [] [ text "1. Pick a Date" ]
        , viewDateInput SelectDate date
        , viewDateInfo date
        ]


viewDatePartInput : String -> String -> DateOffsetField -> Maybe Int -> Html Msg
viewDatePartInput identifier labelText field fieldValue =
    label [ class "date-part-input" ]
        [ text (labelText ++ ":")
        , input
            [ type_ "number"
            , id identifier
            , value (fieldValue |> Maybe.map toString |> Maybe.withDefault "0")
            , Html.Attributes.min "0"
            , pattern "[0-9]*"
            , onInput (ChangeDateOffset field << toInt)
            ]
            []
        ]


maybeUpdateDate : (Int -> Date -> Date) -> Maybe Int -> Date -> Date
maybeUpdateDate updater maybeValue date =
    Just date
        |> Maybe.map2 updater maybeValue
        |> Maybe.withDefault date


computeFutureDate : Model -> Date
computeFutureDate model =
    model.selectedDate
        |> maybeUpdateDate Date.addYears model.years
        |> maybeUpdateDate Date.addMonths model.months
        |> maybeUpdateDate Date.addDays model.days


viewFutureDate : Model -> Html Msg
viewFutureDate model =
    div [ class "future-date" ]
        [ h1 [] [ text "2. Find a Future Date" ]
        , div [ class "date-part-inputs" ]
            [ viewDatePartInput "offset-years" "Years" Years model.years
            , viewDatePartInput "offset-months" "Months" Months model.months
            , viewDatePartInput "offset-days" "Days" Days model.days
            ]
        , div [ class "result" ]
            [ span [] [ text "Future Date: " ]
            , span [ id "future-date" ] [ text <| Date.toDateString (computeFutureDate model) ]
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ viewPickDate model.selectedDate
        , hr [] []
        , viewFutureDate model
        ]



---- UPDATE ----


-- START:type.Msg
type DateOffsetField
    = Years
    | Months
    | Days


type Msg
    = SelectDate (Maybe Date)
    | ChangeDateOffset DateOffsetField (Result String (Maybe Int))
-- END:type.Msg


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        SelectDate (Just date) ->
            { model | selectedDate = date }

        ChangeDateOffset Years (Ok years) ->
            { model | years = years }

        ChangeDateOffset Months (Ok months) ->
            { model | months = months }

        ChangeDateOffset Days (Ok days) ->
            { model | days = days }

        _ ->
            model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, Cmd.none )



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
