(ns mbfpp.oo.nullobject.examples
  (:require [clojure.string :as string]))

(defn example [x]
  (if x
    (println "wasn't nil")
    (println "was nil")))
  
(defmulti example-mm (fn [x] (nil? x)))
  
(defmethod example-mm false [x] (println "wasn't nil"))
(defmethod example-mm true [x] (println "was nil"))

(def null-person {:first-name "John" :last-name "Doe"})
(defn fetch-person [people id]
  (get id people null-person))

(defn person-greeting [person]
  (if person
    (->> (:first-name person) 
      string/capitalize 
      (str "Hello, "))
    "Hello, John")) 

(defn build-person [first-name last-name]
  (if (and first-name last-name)
    {:first-name first-name :last-name last-name}
    {:first-name "John" :last-name "Doe"}))
