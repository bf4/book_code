module Picshare exposing (..)

-- START:import.html
import Html exposing (..)
-- END:import.html
-- START:import.html.attributes
import Html.Attributes exposing (class, src)
-- END:import.html.attributes


main : Html msg
-- START:main
main =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ] -- (1)
            [ div [ class "detailed-photo" ] -- (2)
                [ img [ src "https://programming-elm.com/1.jpg" ] [] -- (3)
                , div [ class "photo-info" ] -- (4)
                    [ h2 [ class "caption" ] [ text "Surfing" ] ] -- (5)
                ]
            ]
        ]
-- END:main
