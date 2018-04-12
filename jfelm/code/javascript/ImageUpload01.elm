-- START:module
module ImageUpload exposing (main)
-- END:module

-- START:imports
import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (class, for, id, multiple, type_)
-- END:imports


-- START:model
type alias Model =
    ()
-- END:model


-- START:init
init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )
-- END:init


-- START:view
view : Model -> Html Msg
view model =
    div [ class "image-upload" ]
        [ label [ for "file-upload" ]
            [ text "+ Add Images" ]
        , input
            [ id "file-upload"
            , type_ "file"
            , multiple True
            ]
            []
        ]
-- END:view


-- START:msg.update
type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
-- END:msg.update


-- START:subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
-- END:subscriptions


-- START:main
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
-- END:main
