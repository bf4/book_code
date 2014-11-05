;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (defmacro square [x] `(* ~x ~x))
;=> #'user/square
user=> @#'square
;=> #<user$square user$square@2a717ef5>
user=> (fn? @#'square)
;=> true
