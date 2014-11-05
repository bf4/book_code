;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(import 'java.io.FileInputStream)
(defn read-file [file-path]
  (let [buffer (byte-array 4096)
        contents (StringBuilder.)]
    (with-open [file-stream (FileInputStream. file-path)]
      (while (not= -1 (.read file-stream buffer))
        (.append contents (String. buffer))))
    (str contents)))
