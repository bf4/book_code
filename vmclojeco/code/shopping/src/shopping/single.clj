;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns shopping.single)
(require '[shopping.store :as store])

;
(def grocery-list #{"soda" "pizza" "noodles" "chips"})
;


;
(defn go-shopping-naive
  "Returns a list of items purchased"
  [shopping-list]
  (loop [[item & items] shopping-list
          cart #{}]
    (if (seq items)
      (recur items (conj cart item))
      cart)))
;

;
(defn shop-for-item [cart item]
  "Shop for an item, return updated cart"
  (if (store/grab item)
    (conj cart item)
    cart))

(defn go-shopping
  "Returns a list of items purchased"
  [shopping-list]
   (reduce shop-for-item [] shopping-list))
;

(comment
  (print "bought" (go-shopping grocery-list))
  )
