;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns shopping.shopping-agents)

; shopping with children

(defn init []
  (def shopping-list (ref #{"milk" "eggs" "butter" "bacon" "carrots" "potatoes" "cheese"}))
  (def shopping-cart (ref #{}))
  (println "initialized"))

;(init)

(defn shop-for
  [item]
  (dosync
   (commute shopping-list disj item)
   (commute shopping-cart conj item)))

;; without children, shopping is straightforward
;  (loop [item (first @shopping-list)
;         items (rest @shopping-list)]
;    (shop-for item)
;    (if-not (empty? items)
;      (recur (first items) (rest items))))

;; with children, things get more complex

;(init)

(def kids #{:alice :bobby :cindi :donnie})

(defn maybe? [f] (if (= 0 (rand-int 3)) (f)))

(defn buy-candy []
  (dosync
   (alter shopping-cart conj (rand-nth ["candy bar" "gum drops" "toy"]))))

(defn dawdle
  "screw around, get lost, maybe buy candy"
  []
  (Thread/sleep (rand-int 3000))
  (maybe? buy-candy))

(defn send-child-for-item
  "eventually shop for an item"
  [child item]
  (println child "is searching for" item)
  (dawdle)
  (shop-for item))

;; again with futures

(init)
(let [available-kids (chan (count kids))]
  (go
   (while (not (empty? @shopping-list))
     (let [kid (<! available-kids)]
       (go
        (send-child-for-item kid (first @shopping-list))
        (println kid "has returned.")
        (>! available-kids kid)))))
  (doseq [k kids] (go (>! available-kids k))))

(println @shopping-cart)
(println @shopping-list)
