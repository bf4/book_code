;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro info-about-caller []
  (pprint {:form &form :env &env})
  `(println "macro was called!"))

user=> (info-about-caller)
;{:form (info-about-caller), :env nil}
;macro was called!
;=> nil
user=> (let [foo "bar"] (info-about-caller))
;{:form (info-about-caller),
; :env {foo #<LocalBinding clojure.lang.Compiler$LocalBinding@23ef55fb>}}
;macro was called!
;=> nil
user=> (let [foo "bar" baz "quux"] (info-about-caller))
;{:form (info-about-caller),
; :env
; {baz #<LocalBinding clojure.lang.Compiler$LocalBinding@3f68eac0>,
;  foo #<LocalBinding clojure.lang.Compiler$LocalBinding@55ab9655>}}
;macro was called!
;=> nil
