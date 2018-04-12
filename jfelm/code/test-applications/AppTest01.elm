module AppTest exposing (..)

import App
import AwesomeDate as Date exposing (Date)
import Expect
import Test exposing (..)


selectedDate : Date
selectedDate =
    Date.create 2012 6 2


futureDate : Date
futureDate =
    Date.create 2015 9 21


initialModel : App.Model
initialModel =
    { selectedDate = selectedDate
    , years = Nothing
    , months = Nothing
    , days = Nothing
    }


modelWithDateOffsets : App.Model
modelWithDateOffsets =
    { initialModel
        | years = Just 3
        , months = Just 2
        , days = Just 50
    }


-- START:selectDate
selectDate : Date -> App.Msg
selectDate date =
    App.SelectDate (Just date)
-- END:selectDate


-- START:changeDateOffset
changeDateOffset : App.DateOffsetField -> Int -> App.Msg
changeDateOffset field amount =
    App.ChangeDateOffset field (Ok (Just amount))
-- END:changeDateOffset


testUpdate : Test
testUpdate =
    describe "update"
        [ test "selects a date" <|
            \_ ->
                App.update (selectDate futureDate) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | selectedDate = futureDate }
        -- START:test.change.years
        , test "changes years" <|
            \_ ->
                App.update (changeDateOffset App.Years 3) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | years = Just 3 }
        -- END:test.change.years
        , test "changes months" <|
            \_ ->
                App.update (changeDateOffset App.Months 2) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | months = Just 2 }
        , test "changes days" <|
            \_ ->
                App.update (changeDateOffset App.Days 50) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | days = Just 50 }
        ]


testView : Test
testView =
    todo "implement view tests"


testEvents : Test
testEvents =
    todo "implement event tests"
