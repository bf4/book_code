;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
; shopping with children

(def shopping-list (ref #{"milk" "eggs" "butter" "bacon"}))
(def shopping-cart (ref #{}))

(defn shop-for
  [item]
  (dosync
   (commute shopping-list disj item)
   (commute shopping-cart conj item)))

; without children, shopping is straightforward

(defn go-shopping-alone
  []
  (loop [item (first @shopping-list)
         items (rest @shopping-list)]
    (shop-for item)
    (if-not (empty? items)
      (recur (first items) (rest items)))))

; with children, things get more complex

(def kids #{:alice :bobby :cindi :donnie})

(def availability-map (ref (into {} (map (juxt identity (constantly true)) kids))))

(defn available? [kid] (kid @availability-map))
(defn maybe? [f] (if (= 0 (rand-int 3)) (f)))

(defn available-kids
  "return a set of currently available kids"
  []
  (reduce-kv #(if %3 (conj %1 %2) %1) #{} @availability-map))

(defn next-kid
  []
  (loop
    [av (available-kids)]
    (if (empty? av)
      (do (Thread/sleep 500)
        (recur (available-kids))))
  (rand-nth (reduce-kv #(if %3 (conj %1 %2) %1) [] a))))

(defn buy-candy []
  (dosync
   (alter shopping-cart conj (rand-nth #{"candy bar" "gum drops" "toy"}))))

(defn assign-item-to-child
  [item child]
  (dosync
    (alter availability-map #(update-in [child] false))
    (alter assigned-items conj item)))

(defn recover-item-from-child
  [item child]
  (dosync
    (alter availability-map #(update-in [child] true))
    (alter assigned-items disj item)))

(defn dawdle
  "screw around, get lost, maybe buy candy"
  []
  (Thread/sleep (rand-int 10000))
  (maybe? buy-candy))

(defn send-child-for-item
  [child item]
  (assign-item-to-child item child)
  (print child "is searching for" item)
  (dawdle)
  (shop-for item)
  (recover-item-and-child item child)
  )

(defn go-shopping-with-kids
  []
  (loop
      []
    (if-not (empty? @shopping-list)
      (send-kid (next-kid) (first @shopping-list))
      (recur))))






