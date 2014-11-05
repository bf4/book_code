;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
;; lein try org.clojars.trptcolin/seqex "2.0.1.1"

(require '[n01se.syntax.repl :as syntax])

(syntax/defn "Squares a number" square [x] (* x x))
; Bad value: "Squares a number"
; Expected var-name
;=> nil

(syntax/syndoc syntax/defn)
;          defn => (defn var-name doc-string? attr-map? (sig-body | (sig-body)+))
;      sig-body => binding-vec prepost-map? form*
;   binding-vec => [binding-form* (& symbol)? (:as symbol)?]
;  binding-form => symbol | binding-vec | binding-map
;   binding-map => {((binding-form form) | (:as symbol) | keys | defaults)*}
;          keys => (:keys | :strs | :syms) [symbol*]
;      defaults => :or {(symbol form)*}
;=> nil

;; The above is even better in the terminal, with its ANSI color output.
