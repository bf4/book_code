(ns zap.core
  (:use compojure.core)
  (:require [compojure.handler :as handler]
            [ring.middleware.resource :refer [wrap-resource]]
            [ring.middleware.params :refer [wrap-params]]
            [ring.middleware.keyword-params :refer [wrap-keyword-params]]
            [zap.views :as views]
            [zap.models :as models]))

;
(defroutes app-routes
  (GET "/" [] ;;(1)
    (views/index))
  (GET "/projects" []
    (views/projects))
  (GET "/projects/new" []
    (views/new-project))
  (POST "/projects" [& params]
    (views/make-project params))

  (GET "/project/:id/issues" [id] ;;(2)
    (views/issues-by-project id))
  (GET "/project/:id/issue/new" [id]
    (views/new-issue id))
  (POST "/project/:id/issues" [id & params] ;;(3)
    (views/make-issue id params))

  (GET "/issue/:id" [id]
    (views/issue id))
  (POST "/issue/:id/comments" [id & params]
    (views/make-comment id params))
  (POST "/issue/:id/close" [id & params]
    (views/close-issue id params)))
;

;
(def app
  (-> app-routes ;;(4)
      (wrap-resource "public") ;;(5)
      wrap-keyword-params
      wrap-params))
;
