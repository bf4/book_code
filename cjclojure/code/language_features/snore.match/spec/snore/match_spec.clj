;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns snore.match-spec
  (:require [speclj.core :refer :all]
            [clojure.string :as string]
            [clojure.walk :as walk]
            [snore.match :refer :all]))

(describe "pattern matching"
  (it "matches an int"
    (let [match-simple-int-input (fn [n]
                                   (match [n]
                                     [0] :zero
                                     [1] :one
                                     [2] :two
                                     :else :other))]
      (should= :zero (match-simple-int-input 0))
      (should= :one (match-simple-int-input 1))
      (should= :two (match-simple-int-input 2))
      (should= :other (match-simple-int-input 3))))

  (it "matches and binds"
    (let [match-and-bind (fn [[a b]]
                           (match [a b]
                                  [0 y] {:axis "Y" :y y}
                                  [x 0] {:axis "X" :x x}
                                  [x y] {:x x :y y}))]
      (should= {:axis "Y" :y 5} (match-and-bind [0 5]))
      (should= {:axis "Y" :y 3} (match-and-bind [0 3]))
      (should= {:axis "X" :x 1} (match-and-bind [1 0]))
      (should= {:axis "X" :x 2} (match-and-bind [2 0]))
      (should= {:x 1 :y 2} (match-and-bind [1 2]))
      (should= {:x 2 :y 1} (match-and-bind [2 1]))))

  (it "handles vector destructuring"
    (let [match-and-bind (fn [[a b]]
                           (match [a b]
                                  [0 [y & more]] {:axis "Y" :y y :more more}
                                  [[x & more] 0] {:axis "X" :x x :more more}
                                  [x y] {:x x :y y}))]
      (should= {:axis "Y" :y 5 :more [6 7]} (match-and-bind [0 [5 6 7]]))
      (should= {:axis "X" :x 1 :more [2 3]} (match-and-bind [[1 2 3] 0]))
      (should= {:x 1 :y 2} (match-and-bind [1 2]))))

  (it "implements merge (from merge-sort)"
    (letfn [(merge [xs ys]
              (loop [acc [] xs xs ys ys]
                (match [(seq xs) (seq ys)]
                  [nil b] (concat acc b)
                  [a nil] (concat acc a)
                  [[x & x-rest] [y & y-rest]]
                    (if (< x y)
                      (recur (conj acc x) x-rest ys)
                      (recur (conj acc y) xs y-rest)))))]
      (should= [1 2 3] (merge [1 2 3] []))
      (should= [1 2 3] (merge [1 2 3] nil))
      (should= [1 2 3 4] (merge [1 2 3] [4]))
      (should= [1 2 3] (merge [] [1 2 3]))
      (should= [1 2 3] (merge nil [1 2 3]))
      (should= [1 2 3 4 5 6 7] (merge [1 3 4 7] [2 5 6]))))

)
