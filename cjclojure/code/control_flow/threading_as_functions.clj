;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(-> 1
    (+ 2)
    (* 3)
    (+ 4)
    (* 5))
;=> 65

(defn thread-first-fn [x & fns]
  (reduce (fn [acc f] (f acc))
          x
          fns))

(thread-first-fn 1
                 #(+ % 2)
                 #(* % 3)
                 #(+ % 4)
                 #(* % 5))
;=> 65

;; or even:
(defn thread-first-fn' [x & fns]
  ((apply comp (reverse fns)) x))
