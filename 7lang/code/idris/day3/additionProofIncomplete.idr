plusCommutes : (a : Nat) -> (b : Nat) -> plus a b = plus b a
plusCommutes Z     b     = ?plusCommutes_0_b
plusCommutes (S a) b     = let hypothesis = plusCommutes a b in
                           ?plusCommutes_Sa_b
