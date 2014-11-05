;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.trampoline
  (:use clojure.test examples.trampoline))

(def ten-fibs [0 1 1 2 3 5 8 13 21 34])

(deftest test-tail-fibo
  (is (= ten-fibs 
	 (map (partial trampoline trampoline-fibo) (range 0 10)))))

(deftest test-my-odd
  (is (= [false true false true false]
	 (map (partial trampoline my-odd?) (range 5)))))

(deftest test-my-even
  (is (= [true false true false true]
	 (map (partial trampoline my-even?) (range 5)))))
