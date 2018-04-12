module Picshare exposing (..)

-- START:import.html
import Html exposing (Html, div, h1, text)
-- END:import.html
-- START:import.html.attributes
import Html.Attributes exposing (class)
-- END:import.html.attributes


main : Html msg
-- START:main
main =
    div [ class "header" ]
        [ h1 [] [ text "Picshare" ] ]
-- END:main
