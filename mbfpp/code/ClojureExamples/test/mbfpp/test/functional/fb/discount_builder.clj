(ns mbfpp.test.functional.fb.discount-builder
  (:use [mbfpp.functional.fb.discount-builder])
  (:use [midje.sweet]))

(fact "Discount creates functions that calculate 0 percent discounts"
      ((discount 0) 100) => 100.0)

(fact "Discount creates functions that calcuate 100 percent discounts"
      ((discount 100) 100) => 0.0)

(fact "Discount calculates discounts between 1 and 99 percent"
      (doseq [percentage (range 1 100)]
        ((discount percentage) 100) => (- 100 (* percentage 100 0.01))))

(fact "Discounts can only be between 0 and 100"
      (discount -1) => (throws AssertionError)
      (discount 101) => (throws AssertionError))