;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.life-without-multi
  (:use clojure.test examples.life-without-multi))

(deftest test-my-println 
  (is (= (with-out-str (my-println "foo")) "foo\n")))

(deftest test-my-print
  (is (thrown? NullPointerException (my-print-1 nil)))
  (are [x y] (= x y)
   (with-out-str (my-print-1 "foo")) "foo"

   (with-out-str (my-print-2 "foo")) "foo"
   (with-out-str (my-print-2 nil)) "nil"
   (with-out-str (my-print-2 [1 2 3])) ""

   (with-out-str (my-print-3 "foo")) "foo"
   (with-out-str (my-print-3 nil)) "nil"
   (with-out-str (my-print-3 [1 2 3])) "[1 2 3]"))
    



  
