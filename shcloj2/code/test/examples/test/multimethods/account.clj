;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.multimethods.account
  (:use clojure.test examples.multimethods.account))

(alias 'acc 'examples.multimethods.account)

(deftest test-interest-rate
  (are [x y] (= x y)
   (interest-rate {:tag ::acc/Checking}) 0M
   (interest-rate {:tag ::acc/Savings}) 0.05M))

(deftest test-account-level
  (are [x y] (= x y)
   (account-level {:tag ::acc/Checking, :balance 4999}) ::acc/Basic
   (account-level {:tag ::acc/Checking, :balance 5000}) ::acc/Premium
   (account-level {:tag ::acc/Savings, :balance 999}) ::acc/Basic
   (account-level {:tag ::acc/Savings, :balance 1000}) ::acc/Premium))

  
