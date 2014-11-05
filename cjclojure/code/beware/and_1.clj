;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro our-and
  ([] true)
  ([x] x)
  ([x & next]
   `(if ~x (our-and ~@next) ~x)))

user=> (our-and true true)
;=> true
user=> (our-and true false)
;=> false
user=> (our-and true true false)
;=> false
user=> (our-and true true nil)
;=> nil
user=> (our-and 1 2 3)
;=> 3
