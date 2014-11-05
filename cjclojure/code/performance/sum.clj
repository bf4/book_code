;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn sum [xs]
  (reduce + xs))
(def collection (range 100))
(bench (sum collection))
;             Execution time mean : 2.078925 µs
;    Execution time std-deviation : 378.988150 ns

(defn array-sum [^ints xs]
  (loop [index 0
         acc 0]
    (if (< index (alength xs))
      (recur (unchecked-inc index) (+ acc (aget xs index)))
      acc)))
(def array (into-array Integer/TYPE (range 100)))
(bench (array-sum array))
;             Execution time mean : 161.939607 ns
;    Execution time std-deviation : 5.566530 ns

