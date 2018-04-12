module Picshare exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)


-- START:baseUrl
baseUrl : String
baseUrl =
    "https://programming-elm.com/"
-- END:baseUrl


-- START:viewDetailedPhoto
viewDetailedPhoto : String -> String -> Html msg
viewDetailedPhoto url caption =
    div [ class "detailed-photo" ]
        [ img [ src url ] []
        , div [ class "photo-info" ]
            [ h2 [ class "caption" ] [ text caption ] ]
        ]
-- END:viewDetailedPhoto


main : Html msg
-- START:main
main =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto (baseUrl ++ "1.jpg") "Surfing"
            , viewDetailedPhoto (baseUrl ++ "2.jpg") "The Fox"
            , viewDetailedPhoto (baseUrl ++ "3.jpg") "Evening"
            ]
        ]
-- END:main
