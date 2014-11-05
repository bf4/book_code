(ns picture-gallery.models.db
  (:require [clojure.java.jdbc :as sql]))

(def db 
  {:subprotocol "postgresql"
   :subname "//localhost/gallery"
   :user "admin"
   :password "admin"})

(defn create-user [user]
  (sql/with-connection
    db
    (sql/insert-record :users user)))
