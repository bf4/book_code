;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.life-without-multi)

(defn my-print [ob]
  (.write *out* ob))
(def my-print-1 my-print)

(defn my-println [ob]
  (my-print ob)
  (.write *out* "\n"))

(defn my-print [ob]
  (cond
   (nil? ob) (.write *out* "nil")
   (string? ob) (.write *out* ob)))

(def my-print-2 my-print)

(require '[clojure.string :as str])
(defn my-print-vector [ob]
  (.write *out*"[")
  (.write *out* (str/join " " ob))
  (.write *out* "]"))

(defn my-print [ob] 
  (cond
   (vector? ob) (my-print-vector ob)
   (nil? ob) (.write *out* "nil")
   (string? ob) (.write *out* ob)))

(def my-print-3 my-print)
