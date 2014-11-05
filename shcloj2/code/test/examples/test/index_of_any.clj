;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.index-of-any
  (:use examples.index-of-any clojure.test))

(deftest test-index-of-any-with-nil-args
  (is (nil? (index-of-any #{\a} nil)))
  (is (nil? (index-of-any nil "foo"))))

(deftest test-index-of-any-with-empty-args
  (is (nil? (index-of-any #{\a} "")))
  (is (nil? (index-of-any #{} "foo"))))

(deftest test-index-of-any-with-match
  (is (zero? (index-of-any #{\z \a} "zzabyycdxx")))
  (is (= 3 (index-of-any #{\b \y} "zzabyycdxx"))))

(deftest test-index-of-any-without-match
  (is (nil? (index-of-any #{\z} "aba"))))


