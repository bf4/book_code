;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.macros.bench-1
  (:use clojure.test examples.macros.bench-1))

(deftest test-bench-1
  (are [x y] (= x y)
   (macroexpand-1 '(examples.macros.bench-1/bench :foo))
   '(clojure.core/let [examples.macros.bench-1/start (java.lang.System/nanoTime) 
	 	       examples.macros.bench-1/result :foo] 
      {:elapsed (clojure.core/- (java.lang.System/nanoTime) examples.macros.bench-1/start), 
       :result examples.macros.bench-1/result})))

