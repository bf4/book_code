module Picshare exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)


-- START:model.alias
type alias Model =
    { url : String
    , caption : String
    , liked : Bool
    }
-- END:model.alias


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


-- START:initialModel.annotation
initialModel : Model
-- END:initialModel.annotation
initialModel =
    { url = baseUrl ++ "1.jpg"
    , caption = "Surfing"
    , liked = False
    }


-- START:viewDetailedPhoto.annotation
viewDetailedPhoto : Model -> Html Msg
-- END:viewDetailedPhoto.annotation
viewDetailedPhoto model =
    let
        buttonClass =
            if model.liked then
                "fa-heart"
            else
                "fa-heart-o"

        msg =
            if model.liked then
                Unlike
            else
                Like
    in
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ div [ class "like-button" ]
                [ i
                    [ class "fa fa-2x"
                    , class buttonClass
                    , onClick msg
                    ]
                    []
                ]
            , h2 [ class "caption" ] [ text model.caption ]
            ]
        ]


-- START:view.annotation
view : Model -> Html Msg
-- END:view.annotation
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model
            ]
        ]


type Msg
    = Like
    | Unlike


-- START:update.annotation
update : Msg -> Model -> Model
-- END:update.annotation
update msg model =
    case msg of
        Like ->
            { model | liked = True }

        Unlike ->
            { model | liked = False }


-- START:main.annotation
main : Program Never Model Msg
-- END:main.annotation
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
