module Main exposing (..)

import App exposing (Flags, Model, Msg, init, update, view)
import Html


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
