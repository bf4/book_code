(ns mbfpp.rso.logging)

(defn standard-out [to-log]
  (fn [] (println to-log)))

(defn timestamp-standard-out [to-log]
  (fn [] (println (str (System/currentTimeMillis) " : " to-log))))

(def history (atom []))
(defn do-logging [logger]
  (swap! history conj logger)
  (logger))
