;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.replace-symbol)

; inspired by http://www.cs.uni.edu/~wallingf/patterns/recursion.html#3
(defn- coll-or-scalar [x & _] (if (coll? x) :collection :scalar))
(defmulti replace-symbol coll-or-scalar) ; <label id="code.replace-symbol.multi"/>
(defmethod replace-symbol :collection [coll oldsym newsym]
  (lazy-seq ; <label id="code.replace-symbol.lazy-seq"/>
   (when (seq coll)
    (cons (replace-symbol (first coll) oldsym newsym) 
	  (replace-symbol (rest coll) oldsym newsym)))))
(defmethod replace-symbol :scalar [obj oldsym newsym] 
  (if (= obj oldsym) newsym obj))

(defn deeply-nested [n]
  (loop [n n
	 result '(bottom)]
    (if (= n 0)
      result
      (recur (dec n) (list result)))))
   

