;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(macroexpand '(assert (= 1 2)))
;=> (if (= 1 2)
;     nil
;     (do (throw (new AssertionError
;                  (str "Assert failed: "
;                       (pr-str (quote (= 1 2))))))))
;;; [indentation for clarity]
