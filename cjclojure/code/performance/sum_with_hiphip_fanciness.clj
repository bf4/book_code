;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn array-sum-of-squares [^ints xs]
  (areduce xs index ret 0 (+ ret (let [x (aget xs index)] (* x x)))))

(bench (array-sum-of-squares array))
;             Execution time mean : 1.419661 µs
;    Execution time std-deviation : 256.799353 ns

(bench (hiphip.int/asum [n array] (* n n)))
;            Execution time mean : 1.591465 µs
;    Execution time std-deviation : 232.503393 ns

