;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (defmacro squares [xs] `(map (fn [x] (* x x)) ~xs))
;=> #'user/squares
user=> (squares (range 10))
;=> CompilerException java.lang.RuntimeException:
;  Can't use qualified name as parameter: user/x, compiling: (NO_SOURCE_PATH:1:1)

