;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro inspect-called-form [& arguments]
  {:form (list 'quote &form)})

user=> ^{:doc "this is good stuff"} (inspect-called-form 1 2 3)
;=> {:form (inspect-called-form 1 2 3)}
user=> (meta (:form *1))
;=> {:doc "this is good stuff", :line 1, :column 1}
