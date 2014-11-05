;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.multimethods.default
  (:use clojure.test examples.multimethods.default))

(deftest test-my-print
  (are [x y] (= x y)
   (with-out-str (my-print "foo")) "foo"
   (with-out-str (my-print 42)) "Not implemented yet..."))


  
