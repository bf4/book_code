;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.macros.chain-3
  (:use clojure.test examples.macros.chain-3))

(deftest test-chain-3
  (are [x y] (= x y)
   (macroexpand-1 '(examples.macros.chain-3/chain a b)) '(. a b))
  (is (thrown? IllegalArgumentException (macroexpand-1 '(examples.macros.chain-3/chain a b c)))))
