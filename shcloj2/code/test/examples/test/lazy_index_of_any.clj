;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.lazy-index-of-any
    (:use examples.lazy-index-of-any clojure.test))

(deftest test-lazy-index-of-any-with-match
  (is (= (with-out-str (is (zero? (index-of-any #{\z \a} "zzabyycdxx"))))
	 "Iterating over z\n"))
  (is (= (with-out-str (is (= 3 (index-of-any #{\b \y} "zzabyycdxx"))))
	 "Iterating over z\nIterating over z\nIterating over a\nIterating over b\n")))



