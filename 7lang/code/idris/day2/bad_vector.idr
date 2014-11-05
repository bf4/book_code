add : Vect n a -> Vect m a -> Vect (n + m) a
add Nil ys = ys
add (x :: xs) ys = x :: add xs xs
