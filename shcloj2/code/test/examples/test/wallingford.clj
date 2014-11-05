;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.wallingford
  (:use clojure.test
        examples.wallingford)) 

(deftest test-replace
  (are [x y] (= x y)
       () (replace-symbol () 'a 'b)
       '(a) (replace-symbol '(a) 'b 'c)
       '(c) (replace-symbol '(b) 'b 'c)
       '(a (d e)) (replace-symbol '(a (d e)) 'b 'c)
       '(c (c c)) (replace-symbol '(b (b b)) 'b 'c)
       '((a a) (((a g r) (f r)) c (d e)) a)
       (replace-symbol '((a b) (((b g r) (f r)) c (d e)) b) 'b 'a)))
