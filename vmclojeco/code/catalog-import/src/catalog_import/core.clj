;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns catalog-import.core)

(require '[clojure.data.csv :as csv]
         '[clojure.java.io :as io])

;
(defrecord CatalogItem [num dept desc price])

(defn read-catalog [file]
  (with-open [in-file (io/reader file)]
    (doall
     (csv/read-csv in-file))))

(def catalog (atom []))
;

(defn make-catalog-item [[name dept desc price]]
  (->CatalogItem name dept desc price))

;
(defn import-catalog-map [data]
  (vec (map make-catalog-item data)))
;

;
(defn import-catalog [data]
  (loop [items       data
         new-catalog []]
    (if (seq items)
      (recur (rest items) (conj new-catalog (first items)))
      new-catalog)))
;

;
(defn import-catalog-fast [data]
  (loop [items       data
         new-catalog (transient  [])]
    (if (seq items)
      (recur (rest items) (conj! new-catalog (first items)))
      (persistent! new-catalog))))
;

(defn- reset-catalog! []
  (reset! catalog []))

(defn -main []
  (let [item-data (read-catalog "resources/long.csv")]
    (time (import-catalog item-data))
    (time (import-catalog-fast item-data))

    ;; Want to see how map compares?
    ;; (reset-catalog!)
    ;; (time (import-catalog-map))
    ;; (println (str "imported " (count @catalog) " items"))
    ))
