(ns mbfpp.functional.ls.examples)

(def integers (range Integer/MAX_VALUE))

(def randoms (repeatedly (fn [] (rand-int Integer/MAX_VALUE))))

(defn get-page [page-num]
  (cond 
    (= page-num 1) "Page1"
    (= page-num 2) "Page2"
    (= page-num 3) "Page3"
    :default nil))

(defn paged-sequence [page-num]
  (let [page (get-page page-num)]
    (when page
      (cons page (lazy-seq (paged-sequence (inc page-num)))))))

(defn paged-sequence-print [page-num]
  (let [page (get-page page-num)]
    (when page
      (println (str "Realizing " page))
      (cons page (lazy-seq (paged-sequence (inc page-num)))))))

(defn print-num [num] (print (str num " ")))

(def print-hellos (repeatedly (fn [] (println "hello, world"))))