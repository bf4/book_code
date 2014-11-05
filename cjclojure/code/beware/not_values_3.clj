;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro do-multiplication [expression]
  (cons `* (rest expression)))

user=> (do-multiplication (+ 3 4))
;=> 12
user=> (map (fn [x] (do-multiplication x)) ['(+ 3 4) '(- 2 3)])
; CompilerException java.lang.IllegalArgumentException:
;   Don't know how to create ISeq from: clojure.lang.Symbol,
;   compiling:(NO_SOURCE_PATH:1:14)
