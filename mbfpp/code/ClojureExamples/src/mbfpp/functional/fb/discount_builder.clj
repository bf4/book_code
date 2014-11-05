(ns mbfpp.functional.fb.discount-builder)

(defn discount [percentage]
  {:pre [(and (>= percentage 0) (<= percentage 100))]}
  (fn [price] (- price (* price percentage 0.01))))
