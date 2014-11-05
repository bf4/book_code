;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.string :as string])
(defn log [& args]
  (println (str "[INFO] " (string/join " : " args))))

user=> (log "hi" "there")
;[INFO] hi : there
;=> nil

user=> (apply log ["hi" "there"])
;[INFO] hi : there
;=> nil

