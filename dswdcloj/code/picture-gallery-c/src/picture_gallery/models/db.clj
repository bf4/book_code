(ns picture-gallery.models.db
  (:require [clojure.java.jdbc :as sql]))

(def db 
  {:subprotocol "postgresql"
   :subname "//localhost/gallery"
   :user "admin"
   :password "admin"})

(defmacro with-db [f & body]
  `(sql/with-connection ~db (~f ~@body)))

(defn create-user [user]
  (with-db sql/insert-record :users user))

(defn get-user [id]
  (with-db sql/with-query-results 
    res ["select * from users where id = ?" id] (first res)))

(defn add-image [userid name]
  (with-db 
    sql/transaction
    (if (sql/with-query-results 
          res 
          ["select userid from images where userid = ? and name = ?" userid name] 
          (empty? res))
      (sql/insert-record :images {:userid userid :name name})
      (throw 
        (Exception. "you have already uploaded an image with the same name")))))
