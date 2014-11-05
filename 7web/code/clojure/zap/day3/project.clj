(defproject com.pragprog.7web/zap "1.0.0"
  :description "Zap your bugs!"
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [org.clojure/data.json "0.2.1"]

                 [ring/ring-core "1.1.8"]
                 [ring/ring-devel "1.1.8"]
                 [compojure "1.1.5"]
                 
                 [korma "0.3.0-RC2"]
                 [org.xerial/sqlite-jdbc "3.7.2"]

                 [hiccup "1.0.2"]
                 [enlive "1.1.1"]
                 [kerodon "0.1.0"]]

  :profiles {:dev {:dependencies [[ring-serve "0.1.2"]]}}

  :plugins [[lein-ring "0.8.3"]]

  :ring {:handler zap.core/app})
