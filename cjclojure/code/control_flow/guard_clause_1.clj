;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn follow-user [user user-to-follow]
  (if (contains? @(:blocked user-to-follow) (:name user))
    (println (:name user-to-follow) "has blocked" (:name user))
    (do
      (println "Adding follow relationship...")
      (swap! (:following user) conj (:name user-to-follow))
      (swap! (:followers user-to-follow) conj (:name user)))))
