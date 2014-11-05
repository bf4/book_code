(ns mbfpp.functional.fb.selector)

(defn selector [& path]
  {:pre [(not (empty? path))]}
  (fn [ds] (get-in ds path)))
