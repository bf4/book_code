;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.server.step-2
  (:use [compojure.core :only (defroutes GET POST)]
        [examples.snippet]
        [ring.util.response :only (redirect)])
  (:require [hiccup.core :as hiccup]
            [hiccup.form-helpers :as form]
            [compojure.route :as route]
            [compojure.handler :as handler]
            [ring.adapter.jetty :as ring]))

(defn new-snippet []
  (hiccup/html
    (form/form-to [:post "/"]
      (form/text-area {:rows 20 :cols 73} "body")
      [:br]
      (form/submit-button "Save"))))

(defn create-snippet [body]
  (if-let [id (insert-snippet body)]
    (redirect (str "/" id))
    (redirect "/")))

(defn show-snippet [id]
  (let [snippet (select-snippet id)]
    (hiccup/html
     [:div [:pre [:code (:body snippet)]]]
     [:div (:created_at snippet)])))

(defroutes routes
  (GET "/" [] (new-snippet))
  (GET "/:id" [id] (show-snippet id))
  (POST "/" [body] (create-snippet body))	
  (route/not-found "<h2>Not Found</h2>"))

(def application (handler/site routes))
