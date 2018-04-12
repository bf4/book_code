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


-- START:feed.alias
type alias Feed =
    List Photo
-- END:feed.alias


-- START:model.alias
type alias Model =
    { feed : Maybe Feed
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
    { feed = Nothing
    }
-- END:initialModel


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchFeed )


fetchFeed : Cmd Msg
-- START:fetchFeed
fetchFeed =
    Http.get (baseUrl ++ "feed") (list photoDecoder)
        |> Http.send LoadFeed
-- END:fetchFeed


viewLoveButton : Photo -> Html Msg
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
            -- START:viewLoveButton
            -- , onClick ToggleLike
            -- END:viewLoveButton
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


viewComments : Photo -> Html Msg
viewComments photo =
    div []
        [ viewCommentList photo.comments
        -- START:viewComments
        , form [ class "new-comment" {--, onSubmit SaveComment --} ]
            [ input
                [ type_ "text"
                , placeholder "Add a comment..."
                , value photo.newComment
                -- , onInput UpdateComment
        -- END:viewComments
                ]
                []
            , button
                [ disabled (String.isEmpty photo.newComment) ]
                [ text "Save" ]
            ]
        ]


viewDetailedPhoto : Photo -> Html Msg
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
viewFeed : Maybe Feed -> Html Msg
viewFeed maybeFeed =
    case maybeFeed of
        Just feed ->
            div [] (List.map viewDetailedPhoto feed)

        Nothing ->
            div [ class "loading-feed" ]
                [ text "Loading Feed..." ]
-- END:viewFeed


view : Model -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            -- START:view
            [ viewFeed model.feed
            ]
            -- END:view
        ]


type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment
    -- START:msg
    | LoadFeed (Result Http.Error Feed)
    -- END:msg


saveNewComment : Photo -> Photo
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


toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }


updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }



updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed updatePhoto maybePhoto =
    Maybe.map updatePhoto maybePhoto


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- START:update
        -- ToggleLike ->
        --     ( { model
        --         | photo = updateFeed toggleLike model.photo
        --       }
        --     , Cmd.none
        --     )
        -- UpdateComment comment ->
        --     ( { model
        --         | photo = updateFeed (updateComment comment) model.photo
        --       }
        --     , Cmd.none
        --     )
        -- SaveComment ->
        --     ( { model
        --         | photo = updateFeed saveNewComment model.photo
        --       }
        --     , Cmd.none
        --     )
        LoadFeed (Ok feed) ->
            ( { model | feed = Just feed }
            , Cmd.none
            )
        LoadFeed (Err _) ->
            ( model, Cmd.none )
        _ ->
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
