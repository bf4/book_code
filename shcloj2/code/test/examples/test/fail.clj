;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.fail
  (:use examples.index-of-any clojure.test))

(deftest test-that-demonstrates-failure
  (is (= 5 (+ 2 2))))

(deftest test-that-demonstrates-error-message
  (is (= 3 Math/PI) "PI is an integer!?"))

(run-tests)
