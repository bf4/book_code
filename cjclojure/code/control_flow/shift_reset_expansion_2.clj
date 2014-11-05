;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(macroexpand '(reset (+ 1 (shift k (k 1)))))
;=> ((clojure.core/fn [G__2268 & rest-args__1225__auto__]
;      ((clojure.core/fn [G__2269 & rest-args__1225__auto__]
;         ((clojure.core/fn [k] (k 1))
;          (clojure.core/fn [G__2270 & rest-args__1225__auto__]
;            (delimc.core/funcall-cc
;              G__2268
;              #<core$identity clojure.core$identity@750a6c68>
;              G__2269
;              G__2270))))
;       1))
;    (delimc.core/function +))

(reset (+ 1 (shift k (k 1))))
;=> 2
