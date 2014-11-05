;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(source special-symbol?)
; (defn special-symbol?
;   "Returns true if s names a special form"
;   {:added "1.0"
;    :static true}
;   [s]
;     (contains? (. clojure.lang.Compiler specials) s))

user=> (sort (keys clojure.lang.Compiler/specials))
;=> (& . case* catch def deftype* do finally fn* if let* letfn* loop*
;     monitor-enter monitor-exit new quote recur reify* set! throw try var
;     clojure.core/import*)
