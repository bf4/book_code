-- START:part1
isLeap : Integer -> Bool
isLeap year = (mod year 400 == 0) ||
              ((mod year 4 == 0) && not (mod year 100 == 0))

numberOfDays : Integer -> Integer -> Integer
numberOfDays year 2 = if isLeap year then 29 else 28
numberOfDays _    9 = 30
numberOfDays _    4 = 30
numberOfDays _    6 = 30
numberOfDays _   11 = 30
numberOfDays _    _ = 31

validDate : Integer -> Integer -> Integer -> Bool
validDate year month day = (day >= 1) &&
                           (day <= numberOfDays year month) &&
                           (month >= 1) &&
                           (month <= 12)
-- END:part1

-- START:part2
data Date : Integer -> Integer -> Integer -> Type where
   makeDate : (y:Integer) -> (m:Integer) -> (d:Integer) -> so (validDate y m d)
            -> Date y m d
-- END:part2

-- START:part3
dateFromUnsafeInput : (y:Integer) -> (m:Integer) -> (d:Integer)
                    -> Maybe (Date y m d)
dateFromUnsafeInput y m d = case choose (validDate y m d) of
                                 Left valid => Just (makeDate y m d valid)
                                 Right _    => Nothing
-- END:part3

