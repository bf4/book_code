(ns hello.core
  (:use compojure.core))
(defroutes app
  (GET "/" []
    "Hello, World!"))
