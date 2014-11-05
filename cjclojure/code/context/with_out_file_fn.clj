;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn with-out-file [file body-fn]
  (with-open [writer (clojure.java.io/writer file :append true)]
    (binding [*out* writer]
      (body-fn))))

(let [file (java.io.File. (System/getProperty "user.home") "event-stream.log")]
  (with-out-file file
    (fn []
      (process-events [{:id 88894} {:id 88895} {:id 88897}])
      (process-events [{:id 88896} {:id 88898}]))))
