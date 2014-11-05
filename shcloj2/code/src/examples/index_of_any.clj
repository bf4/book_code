;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.index-of-any)

(defn index-filter [pred coll]
  (when pred (keep-indexed (fn [idx item] (when (pred item) idx)) coll)))

(defn ^{:test (fn []
                (assert (nil? (index-of-any #{\a} nil)))
                (assert (nil? (index-of-any #{\a} "")))
                (assert (nil? (index-of-any nil "foo")))
                (assert (nil? (index-of-any #{} "foo")))
                (assert (zero? (index-of-any #{\z \a} "zzabyycdxx")))
                (assert (= 3 (index-of-any #{\b \y} "zzabyycdxx")))
                (assert (nil? (index-of-any #{\z} "aba"))))}
  index-of-any
  [pred coll]
  (first (index-filter pred coll)))
