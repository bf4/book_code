-- START:module
port module App exposing (main)
-- END:module

-- START:import.html
import Html exposing (..)
-- END:import.html
import Html.Attributes exposing (class, for, id, multiple, src, type_, value, width)
-- START:import.html.events
import Html.Events exposing (on, onClick, onInput)
-- END:import.html.events
import Json.Decode as Decode exposing (succeed)


onChange : msg -> Html.Attribute msg
onChange msg =
    on "change" (succeed msg)


-- START:type.alias.flags
type alias Flags =
    { imageUploaderId : String
    , note : Note
    }
-- END:type.alias.flags


type alias Image =
    { url : String }


-- START:type.alias.note
type alias Note =
    { title : String
    , contents : String
    , images : List Image
    }
-- END:type.alias.note


port uploadImages : () -> Cmd msg


-- START:port.saveNote
port saveNote : Note -> Cmd msg
-- END:port.saveNote


port receiveImages : (List Image -> msg) -> Sub msg


-- START:type.alias.model
type alias Model =
    { imageUploaderId : String
    , note : Note
    }
-- END:type.alias.model


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model flags.imageUploaderId flags.note, Cmd.none )


viewImage : Image -> Html Msg
viewImage image =
    li [ class "image-upload__image" ]
        [ img
            [ src image.url
            , width 400
            ]
            []
        ]


-- START:viewImageUpload
viewImageUpload : Model -> Html Msg
viewImageUpload model =
-- END:viewImageUpload
    div [ class "image-upload" ]
        [ label [ for model.imageUploaderId ]
            [ text "+ Add Images" ]
        , input
            [ id model.imageUploaderId
            , type_ "file"
            , multiple True
            , onChange UploadImages
            ]
            []
        -- START:viewImageUpload.images
        , ul [ class "image-upload__images" ]
            (List.map viewImage model.note.images)
        -- END:viewImageUpload.images
        ]


-- START:view
view : Model -> Html Msg
view model =
    div [ class "note" ]
        [ div [ class "note__info" ]
            [ h2 [] [ text "Info" ]
            , div [ class "note__title" ]
                [ label [] [ text "Title:" ]
                , input
                    [ type_ "text"
                    , value model.note.title
                    , onInput UpdateTitle
                    ]
                    []
                ]
            , div [ class "note__contents" ]
                [ label [] [ text "Contents:" ]
                , textarea
                    [ value model.note.contents
                    , onInput UpdateContents
                    ]
                    []
                ]
            ]
        , div [ class "note__images" ]
            [ h2 [] [ text "Images" ]
            , viewImageUpload model
            ]
        ]
-- END:view


updateTitle : String -> Note -> Note
updateTitle title note =
    { note | title = title }


updateContents : String -> Note -> Note
updateContents contents note =
    { note | contents = contents }


addImages : List Image -> Note -> Note
addImages images note =
    { note | images = note.images ++ images }


-- START:updateNote
updateNote : (Note -> Note) -> Model -> ( Model, Cmd msg )
updateNote updater model =
    let
        newNote =
            updater model.note
    in
    ( { model | note = newNote }
    , saveNote newNote
    )
-- END:updateNote


type Msg
    = UploadImages
    | ReceiveImages (List Image)
    -- START:msg
    | UpdateTitle String
    | UpdateContents String
    -- END:msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UploadImages ->
            ( model, uploadImages () )

        -- START:update.ReceiveImages
        ReceiveImages images ->
            updateNote (\n -> { n | images = n.images ++ images }) model
        -- END:update.ReceiveImages

        -- START:update.UpdateTitle
        UpdateTitle title ->
            updateNote (\n -> { n | title = title }) model
        -- END:update.UpdateTitle

        -- START:update.UpdateContents
        UpdateContents contents ->
            updateNote (\n -> { n | contents = contents }) model
        -- END:update.UpdateContents


subscriptions : Model -> Sub Msg
subscriptions model =
    receiveImages ReceiveImages


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
