(ns mbfpp.oo.tinyweb.core
  (:require [clojure.string :as str])
  (:import (com.mblinn.oo.tinyweb RenderingException ControllerException)))
(defn- render [view model]
  (try
    (view model)
    (catch Exception e (throw (RenderingException. e)))))
(defn- execute-request [http-request handler]
  (let [controller (handler :controller)
        view (handler :view)]
    (try 
      {:status-code 200
       :body
       (render 
         view
         (controller http-request))}
    (catch ControllerException e {:status-code (.getStatusCode e) :body ""})
    (catch RenderingException e {:status-code  500 
                                 :body "Exception while rendering"})
    (catch Exception e (.printStackTrace e) {:status-code 500 :body ""}))))
(defn- apply-filters [filters http-request]
  (let [composed-filter (reduce comp (reverse filters))]
    (composed-filter http-request)))
(defn tinyweb [request-handlers filters]
  (fn [http-request]
    (let [filtered-request (apply-filters filters http-request)
          path (http-request :path)
          handler (request-handlers path)]
      (execute-request filtered-request handler))))
