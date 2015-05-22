;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns cards.cards)

;
(defrecord Card [rank suit])
;

;
(def ranks "23456789TJQKA")
(def suits "hdcs")

(defn- check [val vals]
  (if (some #{val} (set vals))
    val
    (throw (IllegalArgumentException.
            (format "Invalid value: %s, expected: %s" val vals)))))

(defn card-reader [card]
  (let [[rank suit] card]
    (->Card (check rank ranks) (check suit suits))))
;

;
(defmethod print-method cards.cards.Card [card ^java.io.Writer w]
  (.write w (str "#my/card \"" (:rank card) (:suit card) "\"")))

(defmethod print-dup cards.cards.Card [card w]
  (print-method card w))
;
