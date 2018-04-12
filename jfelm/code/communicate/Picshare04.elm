module Picshare exposing (..)

import Http
import Html exposing (..)
import Html.Attributes exposing (class, disabled, placeholder, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Json.Decode exposing (Decoder, bool, int, list, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, required)


type alias Id =
    Int


type alias Photo =
    { id : Id
    , url : String
    , caption : String
    , liked : Bool
    , comments : List String
    , newComment : String
    }



-- START:model.alias
type alias Model =
    { photo : Maybe Photo
    }
-- END:model.alias


photoDecoder : Decoder Photo
photoDecoder =
    decode Photo
        |> required "id" int
        |> required "url" string
        |> required "caption" string
        |> required "liked" bool
        |> required "comments" (list string)
        |> hardcoded ""


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


initialModel : Model
-- START:initialModel
initialModel =
    { photo =
        Just
            { id = 1
            , url = baseUrl ++ "1.jpg"
            , caption = "Surfing"
            , liked = False
            , comments = [ "Cowabunga, dude!" ]
            , newComment = ""
            }
    }
-- END:initialModel


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchFeed )


fetchFeed : Cmd Msg
fetchFeed =
    Http.get (baseUrl ++ "feed/1") photoDecoder
        |> Http.send LoadFeed



-- START:viewLoveButton
viewLoveButton : Photo -> Html Msg
-- END:viewLoveButton
viewLoveButton photo =
    let
        buttonClass =
            if photo.liked then
                "fa-heart"
            else
                "fa-heart-o"
    in
    div [ class "like-button" ]
        [ i
            [ class "fa fa-2x"
            , class buttonClass
            , onClick ToggleLike
            ]
            []
        ]


viewComment : String -> Html Msg
viewComment comment =
    li []
        [ strong [] [ text "Comment:" ]
        , text (" " ++ comment)
        ]


viewCommentList : List String -> Html Msg
viewCommentList comments =
    case comments of
        [] ->
            text ""

        _ ->
            div [ class "comments" ]
                [ ul []
                    (List.map viewComment comments)
                ]



-- START:viewComments
viewComments : Photo -> Html Msg
-- END:viewComments
viewComments photo =
    div []
        [ viewCommentList photo.comments
        , form [ class "new-comment", onSubmit SaveComment ]
            [ input
                [ type_ "text"
                , placeholder "Add a comment..."
                , value photo.newComment
                , onInput UpdateComment
                ]
                []
            , button
                [ disabled (String.isEmpty photo.newComment) ]
                [ text "Save" ]
            ]
        ]



-- START:viewDetailedPhoto
viewDetailedPhoto : Photo -> Html Msg
-- END:viewDetailedPhoto
viewDetailedPhoto photo =
    div [ class "detailed-photo" ]
        [ img [ src photo.url ] []
        , div [ class "photo-info" ]
            [ viewLoveButton photo
            , h2 [ class "caption" ] [ text photo.caption ]
            , viewComments photo
            ]
        ]



-- START:viewFeed
viewFeed : Maybe Photo -> Html Msg
viewFeed maybePhoto =
    case maybePhoto of
        Just photo ->
            viewDetailedPhoto photo

        Nothing ->
            text ""
-- END:viewFeed


view : Model -> Html Msg
-- START:view
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewFeed model.photo
            ]
        ]
-- END:view


type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment
    | LoadFeed (Result Http.Error Photo)


-- START:saveNewComment
saveNewComment : Photo -> Photo
-- END:saveNewComment
saveNewComment photo =
    case photo.newComment of
        "" ->
            photo

        _ ->
            let
                comment =
                    String.trim photo.newComment
            in
            { photo
                | comments = photo.comments ++ [ comment ]
                , newComment = ""
            }



-- START:photo.update.helpers
toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }


updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }
-- END:photo.update.helpers


-- START:updateFeed
updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed updatePhoto maybePhoto =
    Maybe.map updatePhoto maybePhoto
-- END:updateFeed


-- START:update
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLike ->
            ( { model
                | photo = updateFeed toggleLike model.photo
              }
            , Cmd.none
            )
        UpdateComment comment ->
            ( { model
                | photo = updateFeed (updateComment comment) model.photo
              }
            , Cmd.none
            )
        SaveComment ->
            ( { model
                | photo = updateFeed saveNewComment model.photo
              }
            , Cmd.none
            )
        LoadFeed _ ->
            ( model, Cmd.none )
-- END:update


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
