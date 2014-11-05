(ns picture-gallery.models.db
  (:require [clojure.java.jdbc :as sql]
            [korma.db :refer [defdb transaction]]
            [korma.core :refer :all]))

(def db 
  {:subprotocol "postgresql"
   :subname "//localhost/gallery"
   :user "admin"
   :password "admin"})

(defdb korma-db db)

(defentity users)

(defentity images)

(defn create-user [user]
  (insert users (values user)))

(defn get-user [id]
  (first (select users
                 (where {:id id})
                 (limit 1))))
                 
(defn delete-user [id]
  (delete users (where {:id id})))  

(defn add-image [userid name]  
  (transaction
    (if (empty? (select images 
                        (where {:userid userid :name name})
                        (limit 1)))
      (insert images (values {:userid userid :name name}))
      (throw 
        (Exception. "you have already uploaded an image with the same name")))))
                           
(defn images-by-user [userid]
  (select images (where {:userid userid})))    
(defn delete-image [userid name]
  (delete images (where {:userid userid :name name}))) 

(defn get-gallery-previews []
  (exec-raw
    ["select * from 
     (select *, row_number() over (partition by userid) as row_number from images) 
     as rows where row_number = 1" []]
     :results)) 
