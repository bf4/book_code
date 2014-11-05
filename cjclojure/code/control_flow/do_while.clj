;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defmacro do-while [test & body]
  `(loop []
     ~@body
     (when ~test (recur))))

(defn play-game [secret]
  (let [guess (atom nil)]
    (do-while (not= (str secret) (str @guess))
      (print "Guess the secret I'm thinking: ")
      (flush)
      (reset! guess (read-line)))
    (println "You got it!")))

(play-game "zebra")
; Guess the secret I'm thinking: lion
; Guess the secret I'm thinking: zebra
; You got it!
;=> nil
