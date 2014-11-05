;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn send-email [user messages]
  (Thread/sleep 1000)) ;; this would send email in a real implementation

(def admin-user "kathy@example.com")
(def current-user "colin@example.com")

(defn notify-everyone [messages]
  (apply log messages)
  (send-email admin-user messages)
  (send-email current-user messages))

; CompilerException java.lang.RuntimeException:
;   Can't take value of a macro: #'user/log, compiling:(NO_SOURCE_PATH:2:3)
