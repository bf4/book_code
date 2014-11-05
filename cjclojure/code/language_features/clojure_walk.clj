;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.walk :as cw])
(cw/macroexpand-all '(let [when :now] (when {:now "Go!"})))
;=> (let* [when :now] (if {:now "Go!"} (do)))

;; lein try org.clojars.trptcolin/riddley "0.1.7.1"

(require '[riddley.walk :as rw])
(rw/macroexpand-all '(let [when :now] (when {:now "Go!"})))
;=> (let* [when :now] (when {:now "Go!"}))
