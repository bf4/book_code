(ns picture-gallery.routes.home
  (:require [compojure.core :refer :all]
            [picture-gallery.views.layout :as layout]
            [noir.session :as session]))

(defn home [] 
  (layout/common [:h1 "Hello " (session/get :user)]))

(defroutes home-routes
  (GET "/" [] (home)))
