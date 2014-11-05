;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.male-female-seq)

(declare m f)
(defn- m [n]
  (if (zero? n)
    0
    (- n (f (m (dec n))))))

(defn- f [n]		 
  (if (zero? n)
    1
    (- n (m (f (dec n))))))

(def ^:private m (memoize m))
(def ^:private f (memoize f))

(def m-seq (map m (iterate inc 0)))
(def f-seq (map f (iterate inc 0)))

