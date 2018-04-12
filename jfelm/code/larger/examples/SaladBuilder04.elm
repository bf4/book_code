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


type alias Error =
    String


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


type alias Salad =
    { base : Base , toppings : Set String , dressing : Dressing }


-- START:type.alias.contact
type alias Contact c =
    { c | name : String, email : String, phone : String }
-- END:type.alias.contact


type alias Model =
    { building : Bool
    , sending : Bool
    , success : Bool
    , error : Maybe String
    , salad : Salad
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
    , salad =
        { base = Lettuce
        , toppings = Set.empty
        , dressing = NoDressing
        }
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


viewSending : Html msg
viewSending =
    div [ class "sending" ] [ text "Sending Order..." ]


viewError : Maybe Error -> Html msg
viewError error =
    case error of
        Just errorMessage ->
            div [ class "error" ] [ text errorMessage ]

        Nothing ->
            text ""


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
                    , checked (model.salad.base == Lettuce)
                    , onClick (SaladMsg (SetBase Lettuce))
                    ]
                    []
                , text "Lettuce"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.salad.base == Spinach)
                    , onClick (SaladMsg (SetBase Spinach))
                    ]
                    []
                , text "Spinach"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "base"
                    , checked (model.salad.base == SpringMix)
                    , onClick (SaladMsg (SetBase SpringMix))
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
                    , checked (Set.member (toString Tomatoes) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Tomatoes)
                    ]
                    []
                , text "Tomatoes"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toString Cucumbers) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Cucumbers)
                    ]
                    []
                , text "Cucumbers"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "checkbox"
                    , checked (Set.member (toString Onions) model.salad.toppings)
                    , onCheck (SaladMsg << ToggleTopping Onions)
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
                    , checked (model.salad.dressing == NoDressing)
                    , onClick (SaladMsg (SetDressing NoDressing))
                    ]
                    []
                , text "None"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == Italian)
                    , onClick (SaladMsg (SetDressing Italian))
                    ]
                    []
                , text "Italian"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == RaspberryVinaigrette)
                    , onClick (SaladMsg (SetDressing RaspberryVinaigrette))
                    ]
                    []
                , text "Raspberry Vinaigrette"
                ]
            , label [ class "select-option" ]
                [ input
                    [ type_ "radio"
                    , name "dressing"
                    , checked (model.salad.dressing == OilVinegar)
                    , onClick (SaladMsg (SetDressing OilVinegar))
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
                        -- START:viewBuild.set.name
                        , onInput (ContactMsg << SetName)
                        -- END:viewBuild.set.name
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
                        , onInput (ContactMsg << SetEmail)
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
                        , onInput (ContactMsg << SetPhone)
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
                , td [] [ text (toString model.salad.base) ]
                ]
            , tr []
                [ th [] [ text "Toppings:" ]
                , td []
                    [ ul []
                        (model.salad.toppings
                            |> Set.toList
                            |> List.map (\topping -> li [] [ text topping ])
                        )
                    ]
                ]
            , tr []
                [ th [] [ text "Dressing:" ]
                , td [] [ text (labelForDressing model.salad.dressing) ]
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


viewStep : Model -> Html Msg
viewStep model =
    if model.sending then
        viewSending
    else if model.building then
        viewBuild model
    else
        viewConfirmation model


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "header" ]
            [ text "Saladise - Build a Salad" ]
        , div [ class "content" ]
            [ viewStep model ]
        ]



---- UPDATE ----


type SaladMsg
    = SetBase Base
    | ToggleTopping Topping Bool
    | SetDressing Dressing


-- START:type.ContactMsg
type ContactMsg
    = SetName String
    | SetEmail String
    | SetPhone String
-- END:type.ContactMsg


type Msg
    = SaladMsg SaladMsg
    | ContactMsg ContactMsg
    | Send
    | SubmissionResult (Result Http.Error String)


sendUrl : String
sendUrl =
    "https://programming-elm.com/salad/send"


encodeOrder : Model -> Value
encodeOrder model =
    object
        [ ( "base", string (toString model.salad.base) )
        , ( "toppings", list (model.salad.toppings |> Set.toList |> List.map string) )
        , ( "dressing", string (toString model.salad.dressing) )
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


updateSalad : SaladMsg -> Salad -> Salad
updateSalad msg salad =
    case msg of
        SetBase base ->
            { salad | base = base }

        ToggleTopping topping add ->
            let
                updater =
                    if add then
                        Set.insert
                    else
                        Set.remove
            in
            { salad | toppings = updater (toString topping) salad.toppings }

        SetDressing dressing ->
            { salad | dressing = dressing }


-- START:updateContact
updateContact : ContactMsg -> Contact c -> Contact c
updateContact msg contact =
-- END:updateContact
    case msg of
        SetName name ->
            { contact | name = name }

        SetEmail email ->
            { contact | email = email }

        SetPhone phone ->
            { contact | phone = phone }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaladMsg saladMsg ->
            ( { model | salad = updateSalad saladMsg model.salad }
            , Cmd.none
            )

        -- START:update.ContactMsg
        ContactMsg contactMsg ->
            ( updateContact contactMsg model
            , Cmd.none
            )
        -- END:update.ContactMsg

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
