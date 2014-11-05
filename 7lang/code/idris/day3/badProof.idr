module Proof

data Natural = Zero | Suc Natural

-- START:badProof
plus : Natural -> Natural -> Natural
plus Zero x1    = x1
plus (Suc x) x1 = Suc (Suc (plus x x1))
-- END:badProof
