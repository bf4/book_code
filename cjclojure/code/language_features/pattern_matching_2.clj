;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(it "matches and binds"
  (let [match-and-bind (fn [[a b]]
                         (match [a b]
                           [0 y] {:axis "Y" :y y}
                           [x 0] {:axis "X" :x x}
                           [x y] {:x x :y y}))]
    (should= {:axis "Y" :y 5} (match-and-bind [0 5]))
    (should= {:axis "Y" :y 3} (match-and-bind [0 3]))
    (should= {:axis "X" :x 1} (match-and-bind [1 0]))
    (should= {:axis "X" :x 2} (match-and-bind [2 0]))
    (should= {:x 1 :y 2} (match-and-bind [1 2]))
    (should= {:x 2 :y 1} (match-and-bind [2 1]))))

