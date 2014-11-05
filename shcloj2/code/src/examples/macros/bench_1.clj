;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.macros.bench-1)

; This won't work
(defmacro bench [expr]
  `(let [start (System/nanoTime)
	 result ~expr]
     {:result result :elapsed (- (System/nanoTime) start)}))


