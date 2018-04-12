module AwesomeDate exposing (Date, addYears, create, day, isLeapYear, month, toDateString, year)


type Date
    = Date { year : Int, month : Int, day : Int }


create : Int -> Int -> Int -> Date
create year month day =
    Date { year = year, month = month, day = day }


year : Date -> Int
year (Date { year }) =
    year


month : Date -> Int
month (Date { month }) =
    month


day : Date -> Int
day (Date { day }) =
    day


isLeapYear : Int -> Bool
isLeapYear year =
    let
        isDivisibleBy n =
            rem year n == 0
    in
    isDivisibleBy 4 && not (isDivisibleBy 100) || isDivisibleBy 400


-- START:toDateString
toDateString : Date -> String
toDateString (Date { year, month, day }) =
    [ month, day, year ]
        |> List.map toString
        |> String.join "/"
-- END:toDateString


-- START:addYears
addYears : Int -> Date -> Date
addYears years (Date date) =
    Date { date | year = date.year + years }
        |> preventInvalidLeapDates
-- END:addYears


-- START:preventInvalidLeapDates
preventInvalidLeapDates : Date -> Date
preventInvalidLeapDates (Date ({ year, month, day } as date)) =
    if not (isLeapYear year) && month == 2 && day >= 29 then
        Date { date | day = 28 }
    else
        Date date
-- END:preventInvalidLeapDates
