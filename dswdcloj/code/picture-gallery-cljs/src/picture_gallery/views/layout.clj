(ns picture-gallery.views.layout
  (:require [noir.session :as session]
            [selmer.parser :as parser]
            [ring.util.response :refer [content-type response]]
            [compojure.response :refer [Renderable]]))

(def template-folder "picture_gallery/views/templates/")

(defn utf-8-response [html]
  (content-type (response html) "text/html; charset=utf-8"))

(deftype RenderablePage [template params]
  Renderable
  (render [this request]
    (->> (assoc params
                :context (:context request)
                :user    (session/get :user))
         (parser/render-file (str template-folder template))
         utf-8-response)))

(defn render [template & [params]]
  (RenderablePage. template params))
