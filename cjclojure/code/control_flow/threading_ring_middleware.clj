;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(def app-1
  (wrap-head
    (wrap-file-info
      (wrap-resource (wrap-session
                       (wrap-flash
                         (wrap-params app-handler)))
                     "public"))))


;; The ,,, placeholders represent the result from the previous line
(def app-2
  (-> app-handler                 ;; app-handler
      wrap-params                 ;; (wrap-params ,,,)
      wrap-flash                  ;; (wrap-flash ,,,)
      wrap-session                ;; (wrap-session ,,,)
      (wrap-resource "public")    ;; (wrap-resource ,,, "public")
      wrap-file-info              ;; (wrap-file-info ,,,)
      wrap-head))                 ;; (wrap-head ,,,)

