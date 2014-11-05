;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(defn bootstrap-mysql
  ([] 
     (bootstrap-mysql "file:///Users/stuart/devtools/java/mysql-connector-java-5.0.6/mysql-connector-java-5.0.6-bin.jar"))
  ([jar] 
     (add-classpath jar)
     (java.sql.DriverManager/registerDriver (.newInstance (Class/forName "com.mysql.jdbc.Driver")))))

