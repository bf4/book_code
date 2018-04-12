module Picshare exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


-- START:model
initialModel : { url : String, caption : String }
initialModel =
    { url = baseUrl ++ "1.jpg"
    , caption = "Surfing"
    }
-- END:model


-- START:viewDetailedPhoto
viewDetailedPhoto : { url : String, caption : String } -> Html msg
viewDetailedPhoto model =
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ h2 [ class "caption" ] [ text model.caption ] ]
        ]
-- END:viewDetailedPhoto


-- START:view
view : { url : String, caption : String } -> Html msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model
            ]
        ]
-- END:view


-- START:main
main : Html msg
main =
    view initialModel
-- END:main
