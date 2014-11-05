;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
;; this file contains the intermediate steps in building the
;; Clojurebreaker game. See the clojurebreaker/src directory for the
;; completed code.

(defn exact-matches
  "Given two collections, return the number of positions where
   the collections contain equal items."
  [c1 c2])

(defspec closed-under-addition
  +'
  [^long a ^long b]
  (assert (integer? %)))

(defspec incorrect-spec
  +'
  [^long a ^long b]
  (assert (< a %))
  (assert (< b %)))
