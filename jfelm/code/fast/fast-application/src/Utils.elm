module Utils exposing (normalize)


normalize : String -> String
normalize value =
    value
        |> String.trim
        |> String.toLower
