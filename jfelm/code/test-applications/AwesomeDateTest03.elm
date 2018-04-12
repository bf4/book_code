module AwesomeDateTest exposing (..)

import AwesomeDate as Date exposing (Date)
import Expect
import Test exposing (..)


exampleDate : Date
exampleDate =
    Date.create 2012 6 2


-- START:leapDate
leapDate : Date
leapDate =
    Date.create 2012 2 29
-- END:leapDate


-- START:expectDate
expectDate : Int -> Int -> Int -> Date -> Expect.Expectation
expectDate year month day actualDate =
    let
        expectedDate =
            Date.create year month day
    in
    if actualDate == expectedDate then
        Expect.pass
    else
        Expect.fail <|
            Date.toDateString actualDate
                ++ "\n╷\n│ expectDate\n╵\n"
                ++ Date.toDateString expectedDate
-- END:expectDate


-- START:testDateParts
testDateParts : Test
testDateParts =
    describe "date part getters"
-- END:testDateParts
        [ test "retrieves the year from a date" <|
            \() ->
                Date.year exampleDate
                    |> Expect.equal 2012
        , test "retrieves the month from a date" <|
            \() ->
                Date.month exampleDate
                    |> Expect.equal 6
        , test "retrieves the day from a date" <|
            \() ->
                Date.day exampleDate
                    |> Expect.equal 2
        ]


-- START:testIsLeapYear
testIsLeapYear : Test
testIsLeapYear =
    describe "isLeapYear"
-- END:testIsLeapYear
        [ test "returns true if divisible by 4 but not 100" <|
            \_ ->
                Date.isLeapYear 2012
                    |> Expect.true "Expected leap year"
        , test "returns false if not divisible by 4" <|
            \_ ->
                Date.isLeapYear 2010
                    |> Expect.false "Did not expect leap year"
        , test "returns false if divisible by 4 and 100 but not 400" <|
            \_ ->
                Date.isLeapYear 3000
                    |> Expect.false "Did not expect leap year"
        , test "returns true if divisible by 4, 100, and 400" <|
            \_ ->
                Date.isLeapYear 2000
                    |> Expect.true "Expected leap year"
        ]


-- START:testAddYears
testAddYears : Test
testAddYears =
    describe "addYears"
-- END:testAddYears
        [ test "changes a date's year" <|
            \_ ->
                Date.addYears 2 exampleDate
                    |> expectDate 2014 6 2
        -- START:testAddYears.leap.test
        , test "prevents leap days on non-leap years" <|
            \_ ->
                Date.addYears 1 leapDate
                    |> expectDate 2013 2 28
        -- END:testAddYears.leap.test
        ]
