(ns reporting-example.handler
  (:use compojure.core                
        ring.middleware.resource
        ring.middleware.file-info
        hiccup.middleware
        reporting-example.routes.home)
  (:require [compojure.handler :as handler]
            [compojure.route :as route]))

(defn init []
  (println "reporting-example is starting"))

(defn destroy []
  (println "reporting-example is shutting down"))
  
(defroutes app-routes
  (route/resources "/")
  (route/not-found "Not Found"))

(def app
  (-> (routes home-routes app-routes)
      (handler/site)
      (wrap-base-url)))
