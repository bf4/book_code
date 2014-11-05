;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.java.io :as io])
(defn info-to-file [path text]
  (let [file (io/writer path :append true)]
    (try
      (binding [*out* file]
        (println "[INFO]" text))
      (finally
        (.close file)))))

(defn error-to-file [path text]
  (let [file (io/writer path :append true)]
    (try
      (binding [*out* file]
        (println "[ERROR]" text))
      (finally
        (.close file)))))
