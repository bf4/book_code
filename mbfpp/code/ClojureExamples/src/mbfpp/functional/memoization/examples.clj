(ns mbfpp.functional.memoization.examples)

(defn expensive-lookup [id]
  (Thread/sleep 1000)
  (println (str "Lookup for " id))
  ({42 "foo" 12 "bar" 1 "baz"} id))

(def memoized-expensive-lookup 
  (memoize expensive-lookup))

(def slow-fib
  (fn [n]
    (cond
      (<= n 0) 0
      (< n 2) 1
      :else (+ (slow-fib (- n 1)) (slow-fib (- n 2))))))

(def mem-fib
  (memoize
    (fn [n]
      (cond
        (<= n 0) 0
        (< n 2) 1
        :else (+ (mem-fib (- n 1)) (mem-fib (- n 2)))))))
