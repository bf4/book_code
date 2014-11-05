(ns mbfpp.oo.tinyweb.example
  (:use [mbfpp.oo.tinyweb.core])
  (:require [clojure.string :as str]))

(defn render-greeting [greeting]
  (str "<h2>"greeting"</h2>"))

(defn greeting-view [model]
  (let [rendered-greetings (str/join " " (map render-greeting (:greetings model)))]
    (str "<h1>Friendly Greetings</h1> " rendered-greetings)))

(defn logging-filter [http-request]
  (println (str "In Logging Filter - request for path: " (:path http-request)))
  http-request)

(defn make-greeting [name]
  (let [greetings ["Hello" "Greetings" "Salutations" "Hola"]
        greeting-count (count greetings)]
    (str (greetings (rand-int greeting-count)) ", " name)))
         
(defn handle-greeting [http-request]
  {:greetings (map make-greeting (str/split (:body http-request) #","))})

(def request-handlers 
  {"/greeting" {:controller handle-greeting :view greeting-view}})
(def filters [logging-filter])
(def tinyweb-instance (tinyweb request-handlers filters))
