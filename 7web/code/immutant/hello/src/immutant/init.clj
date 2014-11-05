(ns immutant.init
  (:require [immutant.web :as web]
            hello.core))

(web/start "/" hello.core/app)
