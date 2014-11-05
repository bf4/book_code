;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.functional)

; bad idea
(defn stack-consuming-fibo [n]
  (cond
   (= n 0) 0 ; <label id="code.stack-consuming-fibo.0"/>
   (= n 1) 1 ; <label id="code.stack-consuming-fibo.1"/>
   :else (+ (stack-consuming-fibo (- n 1))    ; <label id="code.stack-consuming-fibo.n"/>
	    (stack-consuming-fibo (- n 2)))))     ; <label id="code.stack-consuming-fibo.n2"/>

(defn tail-fibo [n]
  (letfn [(fib ; <label id="code.tail-fibo.letfn"/>
	   [current next n] ; <label id="code.tail-fibo.args"/>
	   (if (zero? n)
	     current       ; <label id="code.tail-fibo.terminate"/>
	     (fib next (+ current next) (dec n))))] ; <label id="code.tail-fibo.recur"/>
    (fib 0N 1N n))) ; <label id="code.tail-fibo.call"/>

; better but not great
(defn recur-fibo [n]
  (letfn [(fib 
            [current next n]
            (if (zero? n)
              current
              (recur next (+ current next) (dec n))))] ; <label id="code.recur-fibo.recur"/>
    (fib 0N 1N n)))

(defn lazy-seq-fibo 
  ([] 
     (concat [0 1] (lazy-seq-fibo 0N 1N))) ; <label id="code.lazy-seq-fibo.basis"/>
  ([a b]
     (let [n (+ a b)]                    ; <label id="code.lazy-seq-fibo.n"/>
       (lazy-seq                         ; <label id="code.lazy-seq-fibo.lazy-seq"/>
	(cons n (lazy-seq-fibo b n)))))) ; <label id="code.lazy-seq-fibo.cons"/>

(defn fibo []
 (map first (iterate (fn [[a b]] [b (+ a b)]) [0N 1N])))

; holds the head (avoid!)
(def head-fibo (lazy-cat [0N 1N] (map + head-fibo (rest head-fibo))))

(defn count-heads-pairs [coll]
  (loop [cnt 0 coll coll] ; <label id="code.count-heads-loop.loop"/>
    (if (empty? coll) ; <label id="code.count-heads-loop.basis"/>
      cnt
      (recur (if (= :h (first coll) (second coll)) ; <label id="code.count-heads-loop.filter"/>
	       (inc cnt)
	       cnt)
	     (rest coll)))))
(def count-heads-loop count-heads-pairs)

; overly complex, better approaches follow...
(defn by-pairs [coll]
  (let [take-pair (fn [c]                           ; <label id="code.by-pairs.take"/>
		    (when (next c) (take 2 c)))]
    (lazy-seq                                       ; <label id="code.by-pairs.lazy-seq"/>
     (when-let [pair (seq (take-pair coll))]        ; <label id="code.by-pairs.when-let"/>
	 (cons pair (by-pairs (rest coll)))))))     ; <label id="code.by-pairs.cons"/>

(defn count-heads-pairs [coll]
  (count (filter (fn [pair] (every? #(= :h %) pair)) 
		 (by-pairs coll))))
(def count-heads-by-pairs count-heads-pairs)

(def ^{:doc "Count items matching a filter"}
  count-if (comp count filter))

(defn count-runs
 "Count runs of length n where pred is true in coll."
 [n pred coll]
 (count-if #(every? pred %) (partition n 1 coll)))

(def ^{:doc "Count runs of length two that are both heads"}
  count-heads-pairs (partial count-runs 2 #(= % :h)))
(def count-heads-by-runs count-heads-pairs)

(declare my-odd? my-even?)

(defn my-odd? [n]
  (if (= n 0)
    false
    (my-even? (dec n))))

(defn my-even? [n]
  (if (= n 0)
    true
    (my-odd? (dec n))))

(defn parity [n]
  (loop [n n par 0]
    (if (= n 0)
      par
      (recur (dec n) (- 1 par)))))

(defn my-even? [n] (= 0 (parity n)))
(defn my-odd? [n] (= 1 (parity n)))

; almost a curry
(defn faux-curry [& args] (apply partial partial args))

; --------------------------------------------------------------------------------------
; -- See www.cs.brown.edu/~sk/Publications/Papers/Published/sk-automata-macros/paper.pdf
; --------------------------------------------------------------------------------------
(defn machine [stream]
   (let [step {[:init 'c] :more
               [:more 'a] :more
               [:more 'd] :more
               [:more 'r] :end
               [:end nil] true}]
     (loop [state :init
            stream stream]
       (let [next (step [state (first stream)])]
         (when next
           (if (= next true)
               true
             (recur next (rest stream))))))))

  
(declare init more end)

(defn init [stream]
  (if (#{'c} (first stream))
    (more (rest stream))))

(defn more [stream]
  (cond 
   (#{'a 'd} (first stream)) (more (rest stream))
   (#{'r} (first stream)) (end (rest stream))))

(defn end [stream]
  (when-not (seq stream) true))


	      
