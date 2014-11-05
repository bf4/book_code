(ns mbfpp.functional.dsl.examples
  (:require [clojure.string :as str]
            [clojure.java.shell :as shell]))

(defn- print-output [output]
  (println (str "Exit Code: " (:exit output)))
  (if-not (str/blank? (:out output)) (println (:out output)))
  (if-not (str/blank? (:err output)) (println (:err output)))
  output)

(defn command [command-str]
  (let [command-parts (str/split command-str #"\s+")]
    (fn []
      (print-output (apply shell/sh command-parts)))))

(defn command [command-str]
  (let [command-parts (str/split command-str #"\s+")]
    (fn 
      ([] (print-output (apply shell/sh command-parts)))
      ([{old-out :out}] 
        (print-output (apply shell/sh (concat command-parts [:in old-out])))))))

(defn pipe [commands]
  (apply comp (reverse commands)))

(defmacro def-command [name command-str]
  `(def ~name ~(command command-str)))

(defmacro def-pipe [name & command-strs]
  (let [commands (map command command-strs)
        pipe (pipe commands)]
    `(def ~name ~pipe)))

      