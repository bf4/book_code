;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns shopping.family-async  (:require [clojure.core.async :as async :refer :all]
                                     [shopping.store :as store]))

; shopping with children (async channel)

(defn init []
  ;
  (store/init {:eggs 2 :bacon 3 :apples 3
               :candy 5 :soda 2 :milk 1
               :bread 3 :carrots 1 :potatoes 1
               :cheese 3})
  (def shopping-list (ref #{:milk :butter :bacon :eggs
                            :carrots :potatoes :cheese :apples}))
  (def assignments (ref {}))
  (def shopping-cart (ref #{}))
;

  (def kids (chan 4))
  (doseq [k #{:alice :bobby :cindi :donnie}] (go (>!! kids k)))
  (println "initialized."))

(defn maybe? [f] (if (= 0 (rand-int 3)) (f)))



;
(defn dawdle
  "screw around, get lost, maybe buy candy"
  []
  (let [t (rand-int 5000)]
    (Thread/sleep t)
    (maybe? buy-candy)
    ))
;

(defn collect-item-from-child
  [m child]
  (let [item (child  m)]
    (dissoc m child)
    (item)
    (assoc m :assigns (dissoc (:assigns m) child))
    (assoc m :cart (conj (:cart m) item))))

(defn add-item-to-cart
  [m item]
  (conj m item))


(defn disj-1
  [m k item]
  (assoc m k (disj (k m) item)))

;

(defn assignment
  [child]
  (get-in @assignments child))

(defn buy-candy []
  (dosync
   (commute shopping-cart add-item-to-cart (store/grab :candy))))

(defn collect-assignment
  [child]
  (let [item (assignment child)]
    (dosync
     (alter shopping-cart conj item)
     (alter assignments dissoc child)
     (ensure shopping-list) ;; not needed
                            ;; included as an example
     )
    item))

(defn assign-item-to-child
  [child]
  (dosync
   (alter assignments assoc child (first @shopping-list))
   (alter shopping-list disj (assignment child)))
  (assignment child)
  )
;



;

(defn send-child-for-item
  "eventually shop for an item"
  [child item q]
  (println child "is searching for" item)
  (dawdle)
  (collect-assignment child)
  (>!! q child))

(defn go-shopping []
  (init)
  (report)
  (go-loop
   [kid (<! kids)]
   (if (not (empty? @shopping-list))
     (do
       (go
        (send-child-for-item kid (assign-item-to-child kid) kids))
       (recur (<! kids)))
     (println "done shopping.")))
  (report))

(defn report []
  (println "store inventory" @store/inventory)
  (println "shopping-list" @shopping-list)
  (println "assignments"   @assignments)
  (println "shopping-cart" @shopping-cart))

;


;

(comment

;
(def shopping-cart (ref #{})
  :validator-fn #((not (contains? :candy))))
;

;
(defn notify-parent
  [k r _ nv]
  (if (contains? nv :candy)
    (println "there's candy in the cart!")))
;

;
  (add-watch shopping-cart :candy notify-parent)
;
  )
