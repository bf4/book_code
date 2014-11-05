;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.trampoline)

; Example only. Don't write code like this.
(defn trampoline-fibo [n]
  (let [fib (fn fib [f-2 f-1 current]
	      (let [f (+ f-2 f-1)]
		(if (= n current) 
		  f
		  #(fib f-1 f (inc current)))))] ; <label id="code.trampoline.function"/>
  (cond
   (= n 0) 0
   (= n 1) 1
   :else (fib 0N 1 2))))

(declare my-odd? my-even?)

(defn my-odd? [n]
  (if (= n 0)
    false
    #(my-even? (dec n)))) ; <label id="code.trampoline.my-odd"/>

(defn my-even? [n]
  (if (= n 0)
    true
    #(my-odd? (dec n)))) ; <label id="code.trampoline.my-even"/>


