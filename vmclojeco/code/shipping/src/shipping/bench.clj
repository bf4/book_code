;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns shipping.bench
  (:require [shipping.domain :as d]
            [shipping.seq :as s]
            [shipping.reducer :as r]
            [criterium.core :refer (quick-benchmark)]
            [clojure.string :as str])
  (:gen-class))

(defn gen-product []
  {:weight (rand-int 50) :volume (rand-int 100) :class (rand-nth d/classes)})

(defn gen-products [n]
  (vec (repeatedly n #(gen-product))))

(defmacro bench-mean-ms
  "Benchmark expr and return mean in ms"
  [expr]
  `(let [results# (quick-benchmark ~expr nil)]
     (* 1000000 (first (:mean results#)))))

(defn -main [& args]
  (loop [[s & remaining] [32 128 512 2048 8192 32768 131072 524288]]
    (let [products (gen-products s)]
      (when (seq remaining)
        (println (str/join "," [s
                                (bench-mean-ms (s/ground-weight products))
                                (bench-mean-ms (r/ground-weight products))]))
        (recur remaining)))))
