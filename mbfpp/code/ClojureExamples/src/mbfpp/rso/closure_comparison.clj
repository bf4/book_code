(ns mbfpp.rso.closure-comparison)

(defn make-composed-comparison [& comparisons]
  (fn [p1 p2]
    (let [results (for [comparison comparisons] (comparison p1 p2))
          first-non-zero-result
          (some (fn [result] (if (not (= 0 result)) result nil)) results)]
      (if (nil? first-non-zero-result)
        0
        first-non-zero-result))))

(defn first-name-comparison [p1, p2]
  (compare (:first-name p1) (:first-name p2)))

(defn last-name-comparison [p1 p2]
  (compare (:last-name p1) (:last-name p2)))

(def first-and-last-name-comparison
  (make-composed-comparison
    first-name-comparison last-name-comparison))

(def p1 {:first-name "John" :middle-name "" :last-name "Adams"})
(def p2 {:first-name "John" :middle-name "Quincy" :last-name "Adams"})
  