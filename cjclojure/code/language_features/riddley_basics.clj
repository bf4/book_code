;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[riddley.walk :as walk])

(defn malkovichify [expression]
  (walk/walk-exprs
    symbol?                 ;; predicate: should we run the handler on this?
    (constantly 'malkovich) ;; handler: does any desired replacements
    expression))

(malkovichify '(println a b))
;=> (malkovich malkovich malkovich)

