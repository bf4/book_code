;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns n01se.syntax.repl
  (:require [n01se.seqex :refer [cap recap]]
            [n01se.syntax :refer [defterminal defrule defsyntax
                                  cat opt alt rep* rep+
                                  vec-form, map-form, map-pair, list-form
                                  rule sym form string]])
  (:refer-clojure :exclude [let defn]))
(alias 'clj 'clojure.core)

(defterminal prepost-map map?)
(defterminal attr-map map?)
(defterminal doc-string string?)

(declare binding-form)

(defrule binding-vec
  (vec-form (cat (rep* (delay binding-form))
                 (opt (cat '& sym))
                 (opt (cat :as sym)))))

(defrule binding-map
  ;; [complex logic mostly because of destructuring]
)

(defrule binding-form
  (alt sym binding-vec binding-map))

(defrule sig-body
  (cat binding-vec (opt prepost-map) (rep* form)))

(defterminal var-name symbol?)

(defsyntax defn
  (cap (cat var-name
            (opt doc-string)
            (opt attr-map)
            (alt sig-body
                 (rep+ (list-form sig-body))))
       (fn [forms] `(clj/defn ~@forms))))

