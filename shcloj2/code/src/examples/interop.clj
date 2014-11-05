;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.interop)

; performance demo only, don't write code like this
(defn sum-to [n]
  (loop [i 1 sum 0]
    (if (<= i n)
      (recur (inc i) (+ i sum))
      sum)))

(defn integer-sum-to [n]
  (let [n (int n)]
    (loop [i (int 1) sum (int 0)]
      (if (<= i n)
	(recur (inc i) (+ i sum))
	sum))))

(defn unchecked-sum-to [n]
  (let [n (int n)]
    (loop [i (int 1) sum (int 0)]
      (if (<= i n)
	(recur (inc i) (unchecked-add i sum))
	sum))))

(defn better-sum-to [n]
  (reduce + (range 1 (inc n))))

(defn best-sum-to [n]
  (/ (* n (inc n)) 2))
; TODO: a better timer?

(defn painstakingly-create-array []
  (let [arr (make-array String 5)]
    (aset arr 0 "Painstaking")
    (aset arr 1 "to")
    (aset arr 2 "fill")
    (aset arr 3 "in")
    (aset arr 4 "arrays")
    arr))

(import '(org.xml.sax InputSource)
	'(org.xml.sax.helpers DefaultHandler)
	'(java.io StringReader)
	'(javax.xml.parsers SAXParserFactory))

(def print-element-handler
     (proxy [DefaultHandler] [] 
       (startElement            
	[uri local qname atts] 
	(println (format "Saw element: %s" qname)))))

(defn demo-sax-parse [string handler]
  (.. SAXParserFactory newInstance newSAXParser 
      (parse (InputSource. (StringReader. string)) 
	     handler)))

(defn demo-threads []
(dotimes [i 5]
  (.start
   (Thread.
    (fn []
      (Thread/sleep (rand 500))
      (println (format "Finished %d on %s" i (Thread/currentThread)))))))
)

(defn demo-try-finally []
(try
 (throw (Exception. "something failed"))
 (finally
  (println "we get to clean up")))
)  

; not caller-friendly
(defn class-available? [class-name]
  (Class/forName class-name))
(def poor-class-available? class-available?)

(defn class-available? [class-name]
  (try 
   (Class/forName class-name) true
   (catch ClassNotFoundException _ false)))    

(defn describe-class [c]
  {:name (.getName c)
   :final (java.lang.reflect.Modifier/isFinal (.getModifiers c))})
(def untyped-describe-class describe-class)

(defn describe-class [#^Class c]
  {:name (.getName c)
   :final (java.lang.reflect.Modifier/isFinal (.getModifiers c))})
(def typed-describe-class describe-class)


