module SaladBuilder exposing (main)

import Html
    exposing
        ( Html
        , button
        , div
        , h1
        , h2
        , input
        , label
        , li
        , p
        , section
        , table
        , td
        , text
        , th
        , tr
        , ul
        )
import Html.Attributes exposing (checked, class, disabled, name, type_, value)
import Html.Events exposing (onCheck, onClick, onInput)
import Http
import Json.Encode exposing (Value, list, object, string)
import Regex
import Set exposing (Set)


---- MODEL ----


-- START:type.alias.error
type alias Error =
    String
-- END:type.alias.error


type Base
    = Lettuce
    | Spinach
    | SpringMix


type Topping
    = Tomatoes
    | Cucumbers
    | Onions


type Dressing
    = NoDressing
    | Italian
    | RaspberryVinaigrette
    | OilVinegar


type alias Model =
    { building : Bool
    , sending : Bool
    , success : Bool
    , error : Maybe String
    , base : Base
    , toppings : Set String
    , dressing : Dressing
    , name : String
    , email : String
    , phone : String
    }


initialModel : Model
initialModel =
    { building = True
    , sending = False
    , success = False
    , error = Nothing
    , base = Lettuce
    , toppings = Set.empty
    , dressing = NoDressing
    , name = ""
    , email = ""
    , phone = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- VALIDATION ----


isRequired : String -> Bool
isRequired value =
    String.trim value /= ""


isValidEmail : String -> Bool
isValidEmail value =
    Regex.regex "^(([^<>()\\[\\]\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"
        |> Regex.caseInsensitive
        |> flip Regex.contains (String.trim value)


isValidPhone : String -> Bool
isValidPhone value =
    Regex.regex "^\\d{10}$"
        |> flip Regex.contains (String.trim value)


isValid : Model -> Bool
isValid model =
    [ isRequired model.name
    , isRequired model.email
    , isValidEmail model.email
    , isRequired model.phone
    , isValidPhone model.phone
    ]
        |> List.all identity



---- VIEW ----


labelForDressing : Dressing -> String
labelForDressing dressing =
    case dressing of
        NoDressing ->
            "None"

        Italian ->
            "Italian"

        RaspberryVinaigrette ->
            "Raspberry Vinaigrette"

        OilVinegar ->
            "Oil and Vinegar"


-- START:viewSending
viewSending : Html msg
viewSending =
    div [ class "sending" ] [ text "Sending Order..." ]
-- END:viewSending


-- START:viewError
viewError : Maybe Error -> Html msg
viewError error =
    case error of
        Just errorMessage ->
            div [ class "error" ] [ text errorMessage ]

        Nothing ->
            text ""
-- END:viewError


viewBuild : Model -> Html Msg
viewBuild model =
    div []
        [ viewError model.error
        , section [ class "salad-section" ]
            [ h2 [] [ text "1. Select Base" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.base == Lettuce)
                    , onClick SelectLettuce
                    ]
                    []
                , text "Lettuce"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.base == Spinach)
                    , onClick SelectSpinach
                    ]
                    []
                , text "Spinach"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.base == SpringMix)
                    , onClick SelectSpringMix
                    ]
                    []
                , text "Spring Mix"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "2. Select Toppings" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toString Tomatoes) model.toppings)
                    , onCheck ToggleTomatoes
                    ]
                    []
                , text "Tomatoes"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toString Cucumbers) model.toppings)
                    , onCheck ToggleCucumbers
                    ]
                    []
                , text "Cucumbers"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toString Onions) model.toppings)
                    , onCheck ToggleOnions
                    ]
                    []
                , text "Onions"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "3. Select Dressing" ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.dressing == NoDressing)
                    , onClick SelectNoDressing
                    ]
                    []
                , text "None"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.dressing == Italian)
                    , onClick SelectItalian
                    ]
                    []
                , text "Italian"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.dressing == RaspberryVinaigrette)
                    , onClick SelectRaspberryVinaigrette
                    ]
                    []
                , text "Raspberry Vinaigrette"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.dressing == OilVinegar)
                    , onClick SelectOilVinegar
                    ]
                    []
                , text "Oil and Vinegar"
                ]
            ]
        , section [ class "salad-section" ]
            [ h2 [] [ text "4. Enter Contact Info" ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Name:" ]
                    , input
                        [ type_ "text"
                        , value model.name
                        , onInput SetName
                        ]
                        []
                    ]
                ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Email:" ]
                    , input
                        [ type_ "text"
                        , value model.email
                        , onInput SetEmail
                        ]
                        []
                    ]
                ]
            , div [ class "text-input" ]
                [ label []
                    [ div [] [ text "Phone:" ]
                    , input
                        [ type_ "text"
                        , value model.phone
                        , onInput SetPhone
                        ]
                        []
                    ]
                ]
            , button
                [ class "send-button"
                , disabled (not (isValid model))
                , onClick Send
                ]
                [ text "Send Order" ]
            ]
        ]


viewConfirmation : Model -> Html msg
viewConfirmation model =
    div [ class "confirmation" ]
        [ h2 [] [ text "Woo hoo!" ]
        , p [] [ text "Thanks for your order!" ]
        , table []
            [ tr []
                [ th [] [ text "Base:" ]
                , td [] [ text (toString model.base) ]
                ]
            , tr []
                [ th [] [ text "Toppings:" ]
                , td []
                    [ ul []
                        (model.toppings
                            |> Set.toList
                            |> List.map (\topping -> li [] [ text topping ])
                        )
                    ]
                ]
            , tr []
                [ th [] [ text "Dressing:" ]
                , td [] [ text (labelForDressing model.dressing) ]
                ]
            , tr []
                [ th [] [ text "Name:" ]
                , td [] [ text model.name ]
                ]
            , tr []
                [ th [] [ text "Email:" ]
                , td [] [ text model.email ]
                ]
            , tr []
                [ th [] [ text "Phone:" ]
                , td [] [ text model.phone ]
                ]
            ]
        ]


-- START:viewStep
viewStep : Model -> Html Msg
viewStep model =
    if model.sending then
        viewSending
    else if model.building then
        viewBuild model
    else
        viewConfirmation model
-- END:viewStep


-- START:view
view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "header" ]
            [ text "Saladise - Build a Salad" ]
        , div [ class "content" ]
            [ viewStep model ]
        ]
-- END:view



---- UPDATE ----


type Msg
    = SelectLettuce
    | SelectSpinach
    | SelectSpringMix
    | ToggleTomatoes Bool
    | ToggleCucumbers Bool
    | ToggleOnions Bool
    | SelectNoDressing
    | SelectItalian
    | SelectRaspberryVinaigrette
    | SelectOilVinegar
    | SetName String
    | SetEmail String
    | SetPhone String
    | Send
    | SubmissionResult (Result Http.Error String)


sendUrl : String
sendUrl =
    "https://programming-elm.com/salad/send"


encodeOrder : Model -> Value
encodeOrder model =
    object
        [ ( "base", string (toString model.base) )
        , ( "toppings", list (model.toppings |> Set.toList |> List.map string) )
        , ( "dressing", string (toString model.dressing) )
        , ( "name", string model.name )
        , ( "email", string model.email )
        , ( "phone", string model.phone )
        ]


send : Model -> Cmd Msg
send model =
    Http.request
        { method = "POST"
        , headers = []
        , url = sendUrl
        , body = Http.jsonBody (encodeOrder model)
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }
        |> Http.send SubmissionResult


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectLettuce ->
            ( { model | base = Lettuce }
            , Cmd.none
            )

        SelectSpinach ->
            ( { model | base = Spinach }
            , Cmd.none
            )

        SelectSpringMix ->
            ( { model | base = SpringMix }
            , Cmd.none
            )

        ToggleTomatoes add ->
            if add then
                ( { model | toppings = Set.insert (toString Tomatoes) model.toppings }
                , Cmd.none
                )
            else
                ( { model | toppings = Set.remove (toString Tomatoes) model.toppings }
                , Cmd.none
                )

        ToggleCucumbers add ->
            if add then
                ( { model | toppings = Set.insert (toString Cucumbers) model.toppings }
                , Cmd.none
                )
            else
                ( { model | toppings = Set.remove (toString Cucumbers) model.toppings }
                , Cmd.none
                )

        ToggleOnions add ->
            if add then
                ( { model | toppings = Set.insert (toString Onions) model.toppings }
                , Cmd.none
                )
            else
                ( { model | toppings = Set.remove (toString Onions) model.toppings }
                , Cmd.none
                )

        SelectNoDressing ->
            ( { model | dressing = NoDressing }
            , Cmd.none
            )

        SelectItalian ->
            ( { model | dressing = Italian }
            , Cmd.none
            )

        SelectRaspberryVinaigrette ->
            ( { model | dressing = RaspberryVinaigrette }
            , Cmd.none
            )

        SelectOilVinegar ->
            ( { model | dressing = OilVinegar }
            , Cmd.none
            )

        SetName name ->
            ( { model | name = name }
            , Cmd.none
            )

        SetEmail email ->
            ( { model | email = email }
            , Cmd.none
            )

        SetPhone phone ->
            ( { model | phone = phone }
            , Cmd.none
            )

        Send ->
            let
                newModel =
                    { model
                        | building = False
                        , sending = True
                        , error = Nothing
                    }
            in
            ( newModel
            , send newModel
            )

        SubmissionResult (Ok _) ->
            ( { model
                | sending = False
                , success = True
                , error = Nothing
              }
            , Cmd.none
            )

        SubmissionResult (Err _) ->
            ( { model
                | building = True
                , sending = False
                , error = Just "There was a problem sending your order. Please try again."
              }
            , Cmd.none
            )



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
