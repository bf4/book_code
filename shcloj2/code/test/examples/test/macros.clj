;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.macros
  (:use clojure.test examples.macros))

; unless-1 evals args before test
(deftest test-unless-1
  (is (thrown? Exception (unless-1 false (throw (Exception.)))))
  (is (thrown? Exception (unless-1 true (throw (Exception.))))))

; unless-2 evals args before test
(deftest test-unless-2
  (are [x y] (= x y)
   (with-out-str (unless-2 false :foo)) "About to test...\n"
   (with-out-str (unless-2 true :foo)) "About to test...\n"))

; unless-3 is a macro and does the right thing   
(deftest test-unless
  (is (thrown? Exception (unless false (throw (Exception.)))))
  (unless true (throw (Exception.))))

; bad-unless captures a symbol
(deftest test-expansions
  (are [x y] (= x y)
   (macroexpand-1 '(examples.macros/unless false :foo)) '(if false nil :foo)
   (macroexpand-1 '(examples.macros/bad-unless false :foo)) '(if expr nil :foo)))

(deftest test-bench-2
  (are [x y] (= x y)
   (:result (examples.macros/bench (+ 1 2)))
   3))

(deftest test-bench-fn
  (are [x y] (= x y)
   (:result (examples.macros/bench-fn (fn [] (+ 2 2))))
   4))
				      
	    

  
