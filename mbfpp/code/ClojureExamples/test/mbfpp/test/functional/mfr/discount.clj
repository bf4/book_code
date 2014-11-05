(ns mbfpp.test.functional.mfr.discount
  (:use [mbfpp.functional.mfr.discount])
  (:use [midje.sweet]))

(fact "Calculate discount adds a discount of 10% on items twenty dollars or over."
      (calculate-discount [20.0 4.5 50.0 15.75 30.0 3.50]) => 10.0
      (calculate-discount [4.5 15.75 3.50]) => 0.0
      (calculate-discount []) => 0.0)

(fact "Named and anynomous versions of calculate discount work the same."
      (calculate-discount [20.0 4.5 50.0 15.75 30.0 3.50]) => (calculate-discount-namedfn [20.0 4.5 50.0 15.75 30.0 3.50])
      (calculate-discount [4.5 15.75 3.50]) => (calculate-discount-namedfn [4.5 15.75 3.50])
      (calculate-discount []) => (calculate-discount-namedfn []))
