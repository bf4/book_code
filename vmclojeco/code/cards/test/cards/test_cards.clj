;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns cards.test-cards
  (:require [cards.cards :as cards]
            [clojure.test :refer :all]))

(deftest test-reader
  (binding [*data-readers* {'my/card #'cards/card-reader}]
    (is (= (read-string "#my/card \"2c\"")
           (cards/->Card \2 \c)))
    (are [s] (is (thrown? IllegalArgumentException (read-string (str "#my/card \"" s "\""))))
         ""
         "xy"
         "2C"
         "0f"
         "c2")))


