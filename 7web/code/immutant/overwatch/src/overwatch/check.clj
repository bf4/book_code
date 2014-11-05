;
(ns overwatch.check
  (:require [immutant.pipeline :as pl] ;; (1)
            [immutant.cache :as cache]
            [clj-http.client :as http]
            [net.cgrand.enlive-html :as html]
            [clojure.tools.logging :as log])
  (:import [java.io StringReader]
           [java.net URL]))

;

;
(defn fetch-url [url]
  {:url url
   :response (http/get url {:throw-exceptions false})})
;

;
(defn normalize-url [base-url url] ;; (2)
  (cond
   (.startsWith url "http") url ;; (3)
   (.startsWith url "/") ;; (4)
   (let [base-url (URL. base-url)
         new-url (URL. (.getProtocol base-url)
                       (.getHost base-url)
                       (.getPort base-url)
                       url)]
     (str new-url))
   :else ;; (5)
   (let [base (re-find #".*/?" base-url)
         base (if (.endsWith "/" base) base (str base "/"))]
     (str base url))))
;

;
(def fetch-cache ;; (6)
  (cache/cache "fetch" :ttl 1 :units :days))
(def link-cache ;; (7)
  (cache/cache "links" :ttl 2 :units :days))

(defn parse-links [data]
  (let [url (:url data)
        response (:response data)
        nodes (html/html-resource (StringReader. (:body response))) ;; (8)
        links (->> (html/select nodes [[:a (html/attr? :href)]]) ;; (9)
                   (map (comp #(normalize-url url %) :href :attrs)) ;; (10)
                   (apply hash-set url))] ;; (11)
    (log/info "URL:" url links)
    (cache/put fetch-cache url response) ;; (12)
    (cache/put link-cache url links)
    (pl/fanout links))) ;; (13)
;

;
(defn record-result [data]
  (let [url (:url data)
        response (:response data)]
    (log/info "Link:" url (:status response))
    (cache/put fetch-cache url response)))
;

;
(def check-url ;; (14)
  (pl/pipeline :check-url
               fetch-url
               parse-links
               fetch-url ;; (15)
               record-result
               :concurrency 5
               :result-ttl -1))
;
