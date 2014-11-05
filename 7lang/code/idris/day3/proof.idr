-- START:plus
module Proof

data Natural = Zero | Suc Natural

plus : Natural -> Natural -> Natural
-- END:plus

plus Zero x1    = x1
plus (Suc x) x1 = Suc (plus x x1)

-- START:axioms
plusZero : (x : Natural) -> plus x Zero = x
-- END:axioms

plusZero Zero    = ?plusZero_0
plusZero (Suc x) = let hypothesis = plusZero x in
                   ?plusZero_Sx

plusZero_0 = proof {
  trivial
}

plusZero_Sx = proof {
  intros
  rewrite hypothesis
  trivial
}

-- START:axioms
plusSuc  : (x : Natural) -> (y : Natural) -> Suc (plus x y) = plus x (Suc y)
-- END:axioms

plusSuc Zero y    = ?plusSuc_0
plusSuc (Suc x) y = let hypothesis = plusSuc x y in
                    ?plusSuc_Sx

plusSuc_0 = proof {
  intros
  trivial
}

plusSuc_Sx = proof {
  intros
  rewrite hypothesis
  trivial
}

-- START:skeleton
plusCommutes : (x : Natural) -> (y : Natural) -> plus x y = plus y x
-- END:skeleton

-- START:base_case
plusCommutes Zero y = ?plusCommutes_0_y
-- END:base_case

-- START:inductive_step
plusCommutes (Suc x) y = let hypothesis = plusCommutes x y in
                         ?plusCommutes_Sx_y
-- END:inductive_step

-- START:base_case_proof
plusCommutes_0_y = proof {
  intros
  rewrite (plusZero y)
  trivial
}
-- END:base_case_proof

-- START:inductive_step_proof
plusCommutes_Sx_y = proof {
  intros
  rewrite (plusSuc y x)
  rewrite hypothesis
  trivial
}
-- END:inductive_step_proof
