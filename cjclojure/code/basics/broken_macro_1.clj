;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro broken-when [test & body]
  (list test (cons 'do body)))

(broken-when (= 1 1) (println "Math works!"))
; ClassCastException java.lang.Boolean cannot be cast to clojure.lang.IFn
;   user/eval316 (NO_SOURCE_FILE:1)

