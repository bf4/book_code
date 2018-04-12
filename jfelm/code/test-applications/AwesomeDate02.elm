module AwesomeDate exposing (Date, create, day, month, year)


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
