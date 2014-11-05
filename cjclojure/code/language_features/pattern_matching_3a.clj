;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn match-item? [matchable-item input]
  (cond (symbol? matchable-item) true
        (vector? matchable-item)
          (and (sequential? input)
               (every? identity (map match-item? matchable-item input)))
        :else (= input matchable-item)))

(defn create-bindings-map [input match-expression]
  (let [pairs (map vector match-expression (concat input (repeat nil)))]
    (into {} (filter (fn [[k v]]
                       (not (or (keyword? k)
                                (number? k)
                                (nil? k))))
                     pairs))))
