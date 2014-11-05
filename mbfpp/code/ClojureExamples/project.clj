(defproject ClojureExamples "0.1.0-SNAPSHOT"
  :description "Clojure examples for Patterns and Functional Programming"
  :dependencies [[org.clojure/clojure "1.3.0"]]
  :profiles {
             :dev {:dependencies [[midje "1.4.0"]]
                   :plugins [[lein-midje "2.0.0-SNAPSHOT"]
                             [no-man-is-an-island/lein-eclipse "2.0.0"]]}})
