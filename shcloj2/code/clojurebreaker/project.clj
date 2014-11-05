;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(defproject clojurebreaker "0.1.0-SNAPSHOT"
            :description "Clojurebreaker game for Programming Clojure 2nd Edition"
            :dependencies [[org.clojure/clojure "1.3.0"]
                           [org.clojure/math.combinatorics "0.0.1"]
                           [org.clojure/test.generative "0.1.3"]
                           [noir "1.2.0"]]
            :main clojurebreaker.server)
