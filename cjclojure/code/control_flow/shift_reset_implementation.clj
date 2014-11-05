;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns delimc.core)

snip
(defmulti transform (fn [[op & forms] k-expr] (keyword op)))
snip

(defn shift* [cc]
  (throw (Exception.
           "Please ensure shift is called from within the reset macro.")))

(defmacro shift [k & body]
  `(shift* (fn [~k] ~@body)))

(defmethod transform :shift* [cons k-expr]
  (when-not (= (count cons) 2)
    (throw (Exception. "Please ensure shift has one argument.")))
  `(~(first (rest cons)) ~k-expr))

snip

(defmacro reset [& body]
  (binding [*ctx* (Context. nil)]
    (expr-sequence->cps body identity)))

