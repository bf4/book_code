;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
;
(ns shopping.store)

(def inventory (atom {}))

(defn no-negative-values?
  "check values of a map for a negative value"
  [m]
  (every? #(>= % 0) (vals m)))

(defn in-stock?
  "check if an item is in stock"
  [item]
  (let [cnt (item @inventory)]
  (and cnt (> cnt 0))))

(defn init
  "set up store with inventory"
  []
  (set-validator! inventory no-negative-values?)) 

(defn grab 
  "grab an item from the shelves"
  [item]
  (if (in-stock? item)
    (swap! inventory update-in [item] dec)))

(defn stock
  "stock an item on the shelves"
  [item]
  (swap! inventory update-in [item] inc))

;

;
(defn restock
  "stock an item on the shelves"
  [item]
  ; ...
  )
;

;

(define sold-items)

(defn restock-order
  "a watch to restock an item"
  [k r ov nv]
  (doseq [item (for [key (keys ov)
                     :when (not= (key ov) (key nv))] key)]
    (swap! sold-items update-in [item] (fnil inc 0))
    (println "need to restock" item)))

(defn init-with-restock
  "set up store with inventory"
  [m]
  (def inventory (atom m))
  (def sold-items (atom {}))
  (set-validator! inventory no-negative-values?)
  (add-watch inventory :restock  restock-order)) 

;

;

(defn restock-all
  "restock all items sold"
  []
  (swap! inventory #(merge-with + % @sold-items))
  (reset! sold-items {})) 

;

(comment
    (init-with-restock {:eggs 2 :bacon 3 :apples 3 :candy 5 :soda 2 :ham 0})

    )
