(ns overwatch.link
  (:require [immutant.cache :as cache]
            [clj-http.client :as http]))
(defn fetch-slow [url]
  (http/get url))
(def fetch (cache/memo fetch-slow "fetch" :ttl 1 :units :days))
