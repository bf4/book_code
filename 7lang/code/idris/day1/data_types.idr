-- START:part1
data DumbNumber = Naught | One | Two | Three
-- END:part1

-- START:part2
data Natural = Zero | After Natural
-- END:part2

-- START:part3
data MyList a  = Blank | (::) a (MyList a)
-- END:part3

-- START:part4
first : MyList a -> Maybe a
first Blank = Nothing
first  (x :: xs) = Just x
-- END:part4
