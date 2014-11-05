(ns mbfpp.oo.iterator.higher-order-functions)

(defn sum-sequence [s]
  {:pre [(not (empty? s))]}
  (reduce + s))

(defn prepend-hello [names]
  (map (fn [name] (str "Hello, " name)) names))

(def vowel? #{\a \e \i \o \u})
(defn vowels-in-word [word]
  (set (filter vowel? word)))
