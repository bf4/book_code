;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (macroexpand-1 '(our-and (do (println "hi there") (= 1 2)) (= 3 4)))
;=> (if (do (println "hi there") (= 1 2))
;     (user/our-and (= 3 4))
;     (do (println "hi there") (= 1 2)))
