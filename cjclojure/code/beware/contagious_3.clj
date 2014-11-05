;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro notify-everyone [messages]
  `(do
     (send-email admin-user ~messages)
     (send-email current-user ~messages)
     (log ~@messages)))

user=> (notify-everyone ["item #1 processed" "by worker #72"])
;[INFO] item #1 processed : by worker #72
;=> nil

