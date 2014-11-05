;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.test :refer [is]])
(is (= 1 1))
;=> true

(is (= 1 (do (throw (Exception.)) 1)))
; ERROR in clojure.lang.PersistentList$EmptyList@1 (NO_SOURCE_FILE:1)
; expected: (= 1 (do (throw (Exception.)) 1))
;   actual: java.lang.Exception: null
;=> nil

