module Picshare exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)
-- START:import.events
import Html.Events exposing (onClick)
-- END:import.events


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


-- START:model
initialModel : { url : String, caption : String, liked : Bool }
initialModel =
    { url = baseUrl ++ "1.jpg"
    , caption = "Surfing"
    , liked = False
    }
-- END:model


-- START:viewDetailedPhoto
viewDetailedPhoto : { url : String, caption : String, liked : Bool } -> Html Msg -- (1)
viewDetailedPhoto model =
    let
        buttonClass = -- (2)
            if model.liked then
                "fa-heart"
            else
                "fa-heart-o"

        msg = -- (3)
            if model.liked then
                Unlike
            else
                Like
    in
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ div [ class "like-button" ]
                [ i -- (4)
                    [ class "fa fa-2x" -- (5)
                    , class buttonClass -- (6)
                    , onClick msg -- (7)
                    ]
                    []
                ]
            , h2 [ class "caption" ] [ text model.caption ]
            ]
        ]
-- END:viewDetailedPhoto


-- START:view.annotation
view : { url : String, caption : String, liked : Bool } -> Html Msg
-- END:view.annotation
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model
            ]
        ]


-- START:msg
type Msg
    = Like
    | Unlike
-- END:msg


-- START:main.annotation
main : Html Msg
-- END:main.annotation
main =
    view initialModel
