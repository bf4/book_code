;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn calculate-estimate [project-id]
  (let [{:keys [optimistic realistic pessimistic]}
          (fetch-estimates-from-web-service project-id)
        weighted-mean (/ (+ optimistic (* realistic 4) pessimistic) 6)
        std-dev (/ (- pessimistic optimistic) 6)]
    (double (+ weighted-mean (* 2 std-dev)))))
