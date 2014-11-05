(ns mbfpp.test.functional.fb.partial-examples
  (:use [mbfpp.functional.fb.partial-examples])
  (:use [midje.sweet]))

(fact "NY state tax is 0.0645"
      (ny-tax 100) => 6.45)

(fact "PA state tax is 0.045"
      (pa-tax 100) => 4.5)