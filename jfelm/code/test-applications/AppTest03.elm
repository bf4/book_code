module AppTest exposing (..)

import App
import AwesomeDate as Date exposing (Date)
import Expect
import Html.Attributes exposing (type_, value)
import Test exposing (..)
-- START:import.test.html.event
import Test.Html.Event as Event
-- END:import.test.html.event
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, id, tag, text)


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


selectDate : Date -> App.Msg
selectDate date =
    App.SelectDate (Just date)


changeDateOffset : App.DateOffsetField -> Int -> App.Msg
changeDateOffset field amount =
    App.ChangeDateOffset field (Ok (Just amount))


testUpdate : Test
testUpdate =
    describe "update"
        [ test "selects a date" <|
            \_ ->
                App.update (selectDate futureDate) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | selectedDate = futureDate }
        , test "changes years" <|
            \_ ->
                App.update (changeDateOffset App.Years 3) initialModel
                    |> Tuple.first
                    |> Expect.equal { initialModel | years = Just 3 }
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
    describe "view"
        [ test "displays the selected date" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ tag "input", attribute (type_ "date") ]
                    |> Query.has [ attribute (value "2012-06-02") ]
        , test "displays the weekday" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "info-weekday" ]
                    |> Query.has [ text "Saturday" ]
        , test "displays the days in the month" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "info-days" ]
                    |> Query.has [ text "30" ]
        , test "displays if the year is a leap year" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "info-leap-year" ]
                    |> Query.has [ text "Yes" ]
        , test "displays an initial years offset" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-years" ]
                    |> Query.has [ attribute (value "0") ]
        , test "displays an initial months offset" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-months" ]
                    |> Query.has [ attribute (value "0") ]
        , test "displays an initial days offset" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-days" ]
                    |> Query.has [ attribute (value "0") ]
        , test "displays a changeable years offset" <|
            \_ ->
                App.view modelWithDateOffsets
                    |> Query.fromHtml
                    |> Query.find [ id "offset-years" ]
                    |> Query.has [ attribute (value "3") ]
        , test "displays a changeable months offset" <|
            \_ ->
                App.view modelWithDateOffsets
                    |> Query.fromHtml
                    |> Query.find [ id "offset-months" ]
                    |> Query.has [ attribute (value "2") ]
        , test "displays a changeable days offset" <|
            \_ ->
                App.view modelWithDateOffsets
                    |> Query.fromHtml
                    |> Query.find [ id "offset-days" ]
                    |> Query.has [ attribute (value "50") ]
        , test "displays a future date" <|
            \_ ->
                App.view modelWithDateOffsets
                    |> Query.fromHtml
                    |> Query.find [ id "future-date" ]
                    |> Query.has [ text "9/21/2015" ]
        ]


testEvents : Test
testEvents =
    describe "events"
        [ test "receives selected date changes" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ tag "input", attribute (type_ "date") ]
                    |> Event.simulate (Event.input "2015-09-21")
                    |> Event.expect (selectDate futureDate)
        -- START:testEvents.years
        , test "receives years offset changes" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-years" ]
                    |> Event.simulate (Event.input "3")
                    |> Event.expect (changeDateOffset App.Years 3)
        -- END:testEvents.years
        , test "receives months offset changes" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-months" ]
                    |> Event.simulate (Event.input "2")
                    |> Event.expect (changeDateOffset App.Months 2)
        , test "receives days offset changes" <|
            \_ ->
                App.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ id "offset-days" ]
                    |> Event.simulate (Event.input "50")
                    |> Event.expect (changeDateOffset App.Days 50)
        ]
