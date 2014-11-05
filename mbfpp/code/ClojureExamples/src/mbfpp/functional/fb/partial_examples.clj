(ns mbfpp.functional.fb.partial-examples)

(defn add-two-ints [int-one int-two] (+ int-one int-two))

(def add-fourty-two (partial add-two-ints 42))

(defn tax-for-state [state amount]
  (cond
    (= :ny state) (* amount 0.0645)
    (= :pa state) (* amount 0.045)))

(def ny-tax (partial tax-for-state :ny))
(def pa-tax (partial tax-for-state :pa))
