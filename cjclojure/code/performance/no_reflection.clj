;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (defn length-2 [^String x] (.length x))
;=> #'user/length-2
user=> (bench (length-2 "hi there!"))
;             Execution time mean : 1.476211 ns
;    Execution time std-deviation : 0.295418 ns

user=> (bench (.length "hi there!"))
;             Execution time mean : 3.423909 ns
;    Execution time std-deviation : 0.202517 ns
