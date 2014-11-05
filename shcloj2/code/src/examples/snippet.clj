;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.snippet)

(require '[clojure.java.jdbc :as sql])
(defn create-snippets []
  (sql/create-table :snippets
                    [:id :int "IDENTITY" "PRIMARY KEY"]
                    [:body :varchar "NOT NULL"]
                    [:created_at :datetime]))

; replace "snippet-db" with a full path!
(def db {:classname "org.hsqldb.jdbcDriver"
         :subprotocol "hsqldb"
         :subname "file:snippet-db"})

(defn drop-snippets []
  (try
    (sql/drop-table :snippets)
    (catch Exception e)))

(defn insert-snippets []
  (let [timestamp (java.sql.Timestamp. (.getTime (java.util.Date.)))]
    (sql/insert-records :snippets
                        {:body "(println :boo)" :created_at timestamp}
                        {:body "(defn foo [] 1)" :created_at timestamp})))

(defn sample-snippets []
  (sql/with-connection db
    (drop-snippets)
    (create-snippets)
    (insert-snippets)))

(defn reset-snippets []
  (sql/with-connection db
    (drop-snippets)
    (create-snippets)))

(defn ensure-snippets-table-exists []
  (try
    (sql/with-connection db (create-snippets))
    (catch Exception _)))


(defn print-snippets []
  (sql/with-query-results res ["select * from snippets"]
    (println res)))

; Broken!
(defn select-snippets []
  (sql/with-query-results res ["select * from snippets"] res))

(def broken-select-snippets select-snippets)

(defmulti coerce (fn [dest-class src-inst] [dest-class (class src-inst)]))
(defmethod coerce [Long String] [_ inst] (Long/parseLong inst))
(defmethod coerce :default [dest-cls obj] (cast dest-cls obj))

(defn select-snippets []
  (sql/with-connection db
    (sql/with-query-results res
      ["select * from snippets"]
      (doall res))))

(defn sql-query [q]
  (sql/with-query-results res
    q
    (doall res)))

(defn select-snippet [id]
  (sql/with-connection db
    (first (sql-query ["select * from snippets where id = ?" (coerce Long id)]))))

(defn last-created-id
  "Extract the last created id. Must be called in a transaction
   that performed an insert. Expects HSQLDB return structure of
   the form [{:@p0 id}]."
  []
  (first (vals (first (sql-query ["CALL IDENTITY()"])))))

(defn insert-snippet [body]
  (let [timestamp (java.sql.Timestamp. (.getTime (java.util.Date.)))]
    (sql/with-connection db
      (sql/transaction
       (sql/insert-records :snippets
                           {:body body :created_at timestamp})
       (last-created-id)))))
