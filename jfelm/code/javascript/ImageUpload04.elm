port module ImageUpload exposing (main)

import Html exposing (Html, div, img, input, label, li, text, ul)
import Html.Attributes exposing (class, for, id, multiple, src, type_, width)
import Html.Events exposing (on)
import Json.Decode as Decode exposing (succeed)


onChange : msg -> Html.Attribute msg
onChange msg =
    on "change" (succeed msg)


-- START:type.alias.flags
type alias Flags =
    { imageUploaderId : String
    , images : List Image
    }
-- END:type.alias.flags


type alias Image =
    { url : String }


port uploadImages : () -> Cmd msg


port receiveImages : (List Image -> msg) -> Sub msg


-- START:type.alias.model
type alias Model =
    { imageUploaderId : String
    , images : List Image
    }
-- END:type.alias.model


-- START:init
init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model flags.imageUploaderId flags.images, Cmd.none )
-- END:init


viewImage : Image -> Html Msg
viewImage image =
    li [ class "image-upload__image" ]
        [ img
            [ src image.url
            , width 400
            ]
            []
        ]


view : Model -> Html Msg
view model =
    div [ class "image-upload" ]
        -- START:view
        [ label [ for model.imageUploaderId ]
            [ text "+ Add Images" ]
        , input
            [ id model.imageUploaderId
            , type_ "file"
            , multiple True
            , onChange UploadImages
            ]
            []
        -- END:view
        , ul [ class "image-upload__images" ]
            (List.map viewImage model.images)
        ]


type Msg
    = UploadImages
    | ReceiveImages (List Image)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UploadImages ->
            ( model, uploadImages () )

        ReceiveImages images ->
            ( { model | images = images }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    receiveImages ReceiveImages


-- START:main
main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
-- END:main
