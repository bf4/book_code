;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(let [expression (+ 1 2 3 4 5)] ;; expression is bound to 15
  (cons
    (read-string "*")    ;; *
    (rest expression)))  ;; (rest 15)
; IllegalArgumentException Don't know how to create ISeq from: java.lang.Long
;   clojure.lang.RT.seqFrom (RT.java:505)

