;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (def other-numbers '(4 5 6 7 8))
;=> #'user/other-numbers
user=> `(1 2 3 ~other-numbers 9 10)
;=> (1 2 3 (4 5 6 7 8) 9 10)
user=> (concat '(1 2 3) other-numbers '(9 10))
;=> (1 2 3 4 5 6 7 8 9 10)
