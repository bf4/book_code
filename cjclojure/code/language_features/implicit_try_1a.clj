;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro with-implicit-try [& defns]
  `(do
     ~@(map
         (fn [defn-expression]
           (let [initial-args (take 3 defn-expression)
                 body (drop 3 defn-expression)]
             `(~@initial-args (try ~@body))))
         defns)))

(with-implicit-try
  (defn delete-file [path]
    (clojure.java.io/delete-file path)
    (catch java.io.IOException e false)))
