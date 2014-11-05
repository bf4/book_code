;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
;; ascending another ladder rung, treating `when` as a function:

(list 'if 'clauses
  (cons 'do
        '((list 'if (first clauses)
                (if (next clauses)
                  (second clauses)
                  (throw (IllegalArgumentException.
                           "cond requires an even number of forms")))
                (cons 'clojure.core/cond (next (next clauses)))))))

