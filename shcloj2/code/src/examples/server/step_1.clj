;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.server.step-1)

(use '[compojure.core :only (defroutes GET)])
(use '[ring.adapter.jetty :only (run-jetty)])
(require '[compojure.route :as route])

(defroutes routes
  (GET "/ping" [] "pong")
  (route/not-found "<h2>Not Found</h2>"))

(run-jetty routes {:port 8080 :join? false})


