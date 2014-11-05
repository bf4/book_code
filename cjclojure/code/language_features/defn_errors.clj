;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn "Squares a number" square [x] (* x x))
; IllegalArgumentException First argument to defn must be a symbol
;                                  clojure.core/defn (core.clj:277)
; java.lang.IllegalArgumentException: First argument to defn must be a symbol
;                      core.clj:277 clojure.core/defn

;; Not bad, huh? Let's try to remember how destructuring works:

(defn square-pair [(x y)]
  (list (* x x) (* y y)))
; CompilerException java.lang.Exception: Unsupported binding form: (x y),
;                                                         compiling: [...]

;; Still pretty darn good, but doesn't tell us what binding forms *are* valid.
