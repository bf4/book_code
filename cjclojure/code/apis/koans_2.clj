;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns koan-engine.core
  (:require [koan-engine.util :as u]))

(def __ :fill-in-the-blank)
(def ___ (fn [& args] __))

(defmacro meditations [& forms]
  (let [pairs (partition 2 forms)
        tests (map (fn [[doc# code#]]
                     `(u/fancy-assert ~code# ~doc#))
                   pairs)]
    `(do ~@tests)))

