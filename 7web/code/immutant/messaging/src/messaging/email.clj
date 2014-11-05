(ns messaging.email
  (:require [immutant.pipeline :as pl]))

;
(def send-email [username]
  (-> username
      get-email
      make-msg
      send-msg))
;

;;
(comment
;
(require '[immutant.pipeline :as pl])

;
)
;
(def send-email-pipe
  (pl/pipeline "email" ;; (1)
               get-email ;; (2)
               make-msg
               send-msg
               :concurrency 5)) ;; (3)
;

;
(def send-email-pipe2
  (pl/pipeline "email2"
               (pl/step get-email :concurrency 10) ;; (4)
               make-msg
               send-msg
               :concurrency 5))
;

;; dummy implementations
(defn get-email [username]
  (str username "@example.com"))

(defn make-msg [{:keys {username email}}]
  {:to email
   :from "system@eample.com"
   :subject "Greetings!"
   :body (str "Hello, " username "!")})

(defn send-msg [msg]
  ;; pretend we're working
  (Thread/sleep 5000)
  ;; return success
  true)
