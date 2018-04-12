module AwesomeDateTest exposing (..)

-- START:import
import AwesomeDate as Date exposing (Date)
-- END:import
import Expect
import Test exposing (..)


-- START:exampleDate
exampleDate : Date
exampleDate =
    Date.create 2012 6 2
-- END:exampleDate


suite : Test
suite =
    describe "AwesomeDate"
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
