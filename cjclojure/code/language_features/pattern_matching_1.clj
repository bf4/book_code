;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
;; desired API (using vectors so we can match multiple things later on):
(match [x]
  [0] :zero
  [1] :one
  :else :foo)

;; desired macroexpansion:
(cond (= [x] [0]) :zero
      (= [x] [1]) :one
      :else :foo)

;; expected outcomes
(describe "pattern matching"
  (it "matches an int"
    ;; will only compile once we've written `match`
    (let [match-simple-int-input (fn [n]
                                   (match [n]
                                     [0] :zero
                                     [1] :one
                                     [2] :two
                                     :else :other))]
      (should= :zero (match-simple-int-input 0))
      (should= :one (match-simple-int-input 1))
      (should= :two (match-simple-int-input 2))
      (should= :other (match-simple-int-input 3)))))
