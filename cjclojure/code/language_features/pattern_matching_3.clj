;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(it "handles vector destructuring"
  (let [match-and-bind (fn [[a b]]
                         (match [a b]
                                [0 [y & more]] {:axis "Y" :y y :more more}
                                [[x & more] 0] {:axis "X" :x x :more more}
                                [x y] {:x x :y y}))]
    (should= {:axis "Y" :y 5 :more [6 7]} (match-and-bind [0 [5 6 7]]))
    (should= {:axis "X" :x 1 :more [2 3]} (match-and-bind [[1 2 3] 0]))
    (should= {:x 1 :y 2} (match-and-bind [1 2]))))

