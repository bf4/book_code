;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(def grocery-list #{"soda" "pizza" "noodles" "chips"})

(defn go-shopping
  "returns a list of items purchased"
  [shopping-list]
  (loop [item (first shopping-list)
         items (rest shopping-list)
         cart #{}]
    (if (not (empty? items))
      (recur (first items) (rest items) (conj cart item))
      (conj cart item))))

(print "bought" (go-shopping grocery-list))

