(ns messaging.core
  (:use compojure.core))

(defroutes app
  (GET "/" []
    "Hello, Messaging!"))
