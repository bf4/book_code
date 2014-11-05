;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.macros)

; This is doomed to fail...
(defn unless [expr form]
  (if expr nil form))
(def unless-1 unless)

(defn unless [expr form]
  (println "About to test...")
  (if expr nil form))
(def unless-2 unless)

(defmacro unless [expr form]
  (list 'if expr nil form))

(defmacro bad-unless [expr form]
  (list 'if 'expr nil form))

(defn with-out-str-as-fn [f]
  (let [s# (new java.io.StringWriter)]
    (binding [*out* s#]
      (f)           
      (str s#))))

; Don't tell Rich I showed you how to do this.
(defmacro evil-bench [expr]
  `(let [~'start (System/nanoTime)
	 ~'result ~expr]
     {:result ~'result :elapsed (- (System/nanoTime) ~'start)}))

(defmacro bench [expr]
  `(let [start# (System/nanoTime)
	 result# ~expr]
     {:result result# :elapsed (- (System/nanoTime) start#)}))

(defn bench-fn [f]
  (let [start (System/nanoTime)
	result (f)]
     {:result result :elapsed (- (System/nanoTime) start)}))
  




