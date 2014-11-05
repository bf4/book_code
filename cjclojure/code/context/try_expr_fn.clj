;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.test :as test])
(defn try-expr [msg f]
  (try (eval (test/assert-expr msg (f)))
    (catch Throwable t
      (test/do-report {:type :error, :message msg,
                       :expected f, :actual t}))))

(defn our-is
  ([f] (our-is (f) nil))
  ([f msg] (test/try-expr msg f)))

(our-is (fn [] (= 1 1)))
;=> true

(our-is (fn [] (= 1 2)))
; FAIL in clojure.lang.PersistentList$EmptyList@1 (NO_SOURCE_FILE:3)
; expected: f
;   actual: false
;=> false
