(ns zap.basic
  (:use kerodon.core
        clojure.test
        kerodon.test)
  (:require [zap.core :as zap]))

;
(deftest projects-page-exists
  (-> (session zap/app)
      (visit "/projects")
      (has (status? 200) "page exists")
      (within [:h1]
        (has (text? "Project List") "header is there"))))
;
