(ns mbfpp.test.oo.tinyweb.core
  (:use [mbfpp.oo.tinyweb.core])
  (:use [midje.sweet])
  (:import (com.mblinn.oo.tinyweb RenderingException ControllerException)))

(defn hello-controller [http-request]
  {:name (http-request :body)})

(defn hello-view [model]
  (str "<h1>Hello, " (model :name) "</h1>"))

(defn error-controller [http-request]
  (throw (ControllerException. (Integer. 503))))

(defn runtime-error-controller [http-request]
  (throw (RuntimeException.)))

(defn error-view [model]
  (throw (RuntimeException.)))

(def request-handlers
  {"/hello" {:controller hello-controller
             :view hello-view}
   "/error-controller" {:controller error-controller
                        :view hello-view}
   "/runtime-error-controller" {:controller runtime-error-controller
                               :view hello-view}
   "/error-view" {:controller hello-controller
                  :view error-view}})

(defn filter-one [http-request]
  (assoc
    http-request
    :body (str "a" (:body http-request))))

(defn filter-two [http-request]
  (assoc
    http-request
    :body (str "b" (:body http-request))))

(fact "Tinyweb should return an http request with a 200 status and body created by the controller and view corresponding to the request path."
      (let [tw (tinyweb request-handlers [])
            http-request {:path "/hello" :body "Mike" :headers {}}]
        (tw http-request) => {:status-code 200 :body "<h1>Hello, Mike</h1>"}))

(fact "Tinyweb applies filters in the order they're specified."
      (let [tw (tinyweb request-handlers [filter-one filter-two])
            http-request {:path "/hello" :body "" :headers {}}]
        (tw http-request) => {:status-code 200 :body "<h1>Hello, ab</h1>"}))

(fact "When a controller throws a ControllerException, Tinyweb returns the statuscode included in it."
      (let [tw (tinyweb request-handlers [])
            http-request {:path "/error-controller" :body ""}]
        (tw http-request) => {:status-code 503 :body ""}))

(fact "When a controller throws an exception other than a ControllerException, Tinyweb returns a 500 status code."
      (let [tw (tinyweb request-handlers [])
            http-request {:path "/runtime-error-controller" :body ""}]
        (tw http-request) => {:status-code 500 :body ""}))

(fact "When view code throws an exception, a 500 response is returned."
      (let [tw (tinyweb request-handlers [])
            http-request {:path "/error-view" :body ""}]
        (tw http-request) => {:status-code 500 :body "Exception while rendering"}))

