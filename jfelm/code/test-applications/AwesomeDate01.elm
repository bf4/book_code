-- START:module
module AwesomeDate exposing (Date, create, year)
-- END:module


-- START:type.Date
type Date
    = Date { year : Int, month : Int, day : Int }
-- END:type.Date


-- START:create
create : Int -> Int -> Int -> Date
create year month day =
    Date { year = year, month = month, day = day }
-- END:create


-- START:year
year : Date -> Int
year (Date { year }) =
    year
-- END:year
