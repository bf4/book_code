;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require '[clojure.string :as string])
(defmacro log [& args]
  `(println (str "[INFO] " (string/join " : " ~(vec args)))))

user=> (log "that went well")
;[INFO] that went well
;=> nil
user=> (log "item #1 created" "by user #42")
; [INFO] item #1 created : by user #42
;=> nil

