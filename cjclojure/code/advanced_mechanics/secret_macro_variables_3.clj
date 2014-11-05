;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro inspect-caller-locals-1 []
  (->> (keys &env)
       (map (fn [k] [`(quote ~k) k]))
       (into {})))

(defmacro inspect-caller-locals-2 []
  (->> (keys &env)
       (map (fn [k] [(list 'quote k) k]))
       (into {})))

user=> (inspect-caller-locals-1)
{}
user=> (inspect-caller-locals-2)
{}
user=> (let [foo "bar" baz "quux"] (inspect-caller-locals-1))
{baz "quux", foo "bar"}
user=> (let [foo "bar" baz "quux"] (inspect-caller-locals-2))
{baz "quux", foo "bar"}
