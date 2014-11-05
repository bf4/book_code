;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro calculate-estimate [{:keys [optimistic realistic pessimistic]}]
  (let [weighted-mean (/ (+ optimistic (* realistic 4) pessimistic) 6)
        std-dev (/ (- pessimistic optimistic) 6)]
    (double (+ weighted-mean (* 2 std-dev)))))

user=> (calculate-estimate {:optimistic 3 :realistic 5 :pessimistic 8})
;=> 6.833333333333333

user=> (bench (calculate-estimate {:optimistic 3 :realistic 5 :pessimistic 8}))
;             Execution time mean : 4.814157 ns
;    Execution time std-deviation : 0.761096 ns
