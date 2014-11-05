(ns hello.core
  (:use compojure.core)) ;(1)
(defroutes app ;(2)
  (GET "/" [] ;(3)
    "Hello, World!"))
