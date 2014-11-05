;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.lazy-index-of-any)

(defn logging-seq [coll]
  (lazy-seq
   (when-let [s (seq coll)]
       (do (println "Iterating over" (first s))
	   (cons (first s) (logging-seq (rest s)))))))

(defn indexed [s] (map vector (iterate inc 0) s (logging-seq s)))
(defn index-filter [pred coll]
  (when pred (for [[idx elt] (indexed coll) :when (pred elt)] idx)))
(defn index-of-any [pred coll]
  (first (index-filter pred coll)))
		 
