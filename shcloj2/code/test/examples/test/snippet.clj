;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.snippet
  (:use clojure.test
        examples.snippet)
  (:require [clojure.java.jdbc :as sql]))

(deftest insert-and-select-some-snippets
  (sample-snippets)
  (is (= [{:id 0, :body "(println :boo)"}
          {:id 1, :body "(defn foo [] 1)"}]
         (map #(select-keys % [:id :body]) (select-snippets))))
  (insert-snippet "boo!")
  (is (= {:id 2, :body "boo!"}
         (select-keys (select-snippet 2) [:id :body]))))

(deftest drop-and-create-snippets-table
  (sql/with-connection db (drop-snippets))
  (is (= "Table not found in statement [select * from snippets]"
         (.getMessage (is (thrown? java.sql.SQLException (select-snippets))))))
  (ensure-snippets-table-exists)
  (is (nil? (select-snippets))))
