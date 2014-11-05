(ns mbfpp.functional.mfr.discount)

(defn calculate-discount [prices]
  (reduce +
          (map (fn [price] (* price 0.10)) 
               (filter (fn [price] (>= price 20.0)) prices))))

(defn calculate-discount-namedfn [prices]
  (letfn [(twenty-or-greater? [price] (>= price 20.0))
          (ten-percent [price] (* price 0.10))]
         (reduce + 0.0 (map ten-percent (filter twenty-or-greater? prices)))))
         
(def bill [20.0 4.5 50.0 15.75 30.0 3.50])