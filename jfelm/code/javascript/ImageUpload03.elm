port module ImageUpload exposing (main)

-- START:import.html
import Html exposing (Html, div, img, input, label, li, text, ul)
import Html.Attributes exposing (class, for, id, multiple, src, type_, width)
-- END:import.html
import Html.Events exposing (on)
import Json.Decode as Decode exposing (succeed)


onChange : msg -> Html.Attribute msg
onChange msg =
    on "change" (succeed msg)


-- START:type.alias.image
type alias Image =
    { url : String }
-- END:type.alias.image


port uploadImages : () -> Cmd msg


-- START:port.receiveImages
port receiveImages : (List Image -> msg) -> Sub msg
-- END:port.receiveImages


-- START:type.alias.model
type alias Model =
    { images : List Image }
-- END:type.alias.model


init : ( Model, Cmd Msg )
-- START:init
init =
    ( Model [], Cmd.none )
-- END:init


-- START:viewImage
viewImage : Image -> Html Msg
viewImage image =
    li [ class "image-upload__image" ]
        [ img
            [ src image.url
            , width 400
            ]
            []
        ]
-- END:viewImage


view : Model -> Html Msg
view model =
    div [ class "image-upload" ]
        [ label [ for "file-upload" ]
            [ text "+ Add Images" ]
        , input
            [ id "file-upload"
            , type_ "file"
            , multiple True
            , onChange UploadImages
            ]
            []
        -- START:view
        , ul [ class "image-upload__images" ]
            (List.map viewImage model.images)
        -- END:view
        ]


type Msg
    = UploadImages
    -- START:msg
    | ReceiveImages (List Image)
    -- END:msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UploadImages ->
            ( model, uploadImages () )

        -- START:update
        ReceiveImages images ->
            ( { model | images = images }
            , Cmd.none
            )
        -- END:update


subscriptions : Model -> Sub Msg
-- START:subscriptions
subscriptions model =
    receiveImages ReceiveImages
-- END:subscriptions


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
