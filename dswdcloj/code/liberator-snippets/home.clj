<code file="code/liberator-snippets/home.clj" part="home-resource"/>
(ns liberator-service.routes.home  
  (:require [compojure.core :refer :all]
            [liberator.core 
             :refer [defresource resource request-method-in]]))

(defroutes home-routes
  (ANY "/" request 
       (resource 
         :handle-ok "Hello World!"
         :etag "fixed-etag"
         :available-media-types ["text/plain"])))

(defresource home
  :handle-ok "Hello World!"
  :etag "fixed-etag"
  :available-media-types ["text/plain"])
  
(defroutes home-routes
  (ANY "/" request home))

(defresource home
  :service-available? false
  :handle-ok "Hello World!"
  :etag "fixed-etag"
  :available-media-types ["text/plain"])

(defresource home
  :method-allowed?
  (fn [context] 
    (= :get (get-in context [:request :request-method])))
  :handle-ok "Hello World!"
  :etag "fixed-etag"
  :available-media-types ["text/plain"])

(defresource home
  :service-available? true
  
  :method-allowed? (request-method-in :get)
  
  :handle-method-not-allowed 
  (fn [context]
    (str (get-in context [:request :request-method]) " is not allowed"))  
  
  :handle-ok "Hello World!"
  :etag "fixed-etag"
  :available-media-types ["text/plain"])

(defresource home
  :service-available? false
  :handle-service-not-available
  "service is currently unavailable..."
  
  :method-allowed? (request-method-in :get)
  :handle-method-not-allowed 
  (fn [context]
    (str (get-in context [:request :request-method]) " is not allowed"))  
  
  :handle-ok "Hello World!"
  :etag "fixed-etag"
  :available-media-types ["text/plain"])


(defresource add-user
  :method-allowed? (request-method-in :post)
  :post!  
  (fn [context]             
    (let [params (get-in context [:request :form-params])] 
      (swap! users conj (get params "user"))))
  :handle-created (fn [_] (generate-string @users))
  :available-media-types ["application/json"])


(defresource add-user
  :method-allowed? (request-method-in :post)
  :post!  
  (fn [context]             
    (let [params (get-in context [:request :form-params])] 
      (swap! users conj (get params "user"))))
  :handle-created (generate-string @users)
  :available-media-types ["application/json"])

