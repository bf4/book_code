;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro when-falsy [test & body]
  (list 'when (list 'not test)
        (cons 'do body)))

(macroexpand-1 '(when-falsy (= 1 2) (println "hi!")))
;=> (when (not (= 1 2)) (do (println "hi!")))

(macroexpand '(when-falsy (= 1 2) (println "hi!")))
;=> (if (not (= 1 2)) (do (do (println "hi!"))))
