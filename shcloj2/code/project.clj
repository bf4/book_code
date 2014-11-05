;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(defproject programming-clojure "1.3.0"
  :description "Examples from Programming Clojure"
  :aot [examples.tasklist]
  :dependencies [[org.clojure/clojure "1.3.0"]
                 [org.clojure/java.jdbc "0.0.6"]
                 [org.clojure/test.generative "0.1.2"]
                 [ring "0.3.11" :exclusions [org.clojure/clojure
                                             org.clojure/clojure-contrib]]
                 [compojure "0.6.5"]
                 [hiccup "0.3.6"]
                 [jline "0.9.94"]
                 [hsqldb "1.8.0.10"]])
