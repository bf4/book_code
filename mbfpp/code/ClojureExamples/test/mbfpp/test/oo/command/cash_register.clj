(ns mbfpp.test.oo.command.cash-register
  (:use [mbfpp.oo.command.cash-register])
  (:use [midje.sweet]))

(fact "Cash register's operations all work"
      (let [r (make-cash-register)]
        @r => 0
        (add-cash r 100) => 100
        (remove-cash r 50) => 50
        (reset r) => 0))

(fact "Executing a purchase adds cash to the register."
      (let [r (make-cash-register)
            p (make-purchase r 100)]
        (p) => 100))

(fact "execute-purchase executes a purchas and adds it to purchase history."
      (let [r (make-cash-register)
            p1 (make-purchase r 100)
            p2 (make-purchase r 50)]
        (execute-purchase p1)
        (execute-purchase p2)
        @r => 150
        (count @purchases) => 2))
        