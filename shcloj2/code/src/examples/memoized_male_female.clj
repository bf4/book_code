;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.memoized-male-female)

; Hofstadter's Male and Female Sequences from GEB
; See http://en.wikipedia.org/wiki/Hofstadter_sequence
(declare m f)
(defn- m [n]
  (if (zero? n)
    0
    (- n (f (m (dec n))))))

(defn- f [n]		 
  (if (zero? n)
    1
    (- n (m (f (dec n))))))

(def m (memoize m))
(def f (memoize f))

