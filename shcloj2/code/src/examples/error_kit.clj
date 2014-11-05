;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
; example inspired by http://gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html
(ns examples.error-kit
 (:use [clojure.contrib.error-kit]))

(deferror malformed-log-entry [] [msg]
  {:msg msg
   :unhandled (throw-msg IllegalArgumentException)})

; imaginary log message format:
; 2008-10-05 12:14:00 WARN Some warning message here...
(defn parse-log-entry [entry]
  (or
    (next (re-matches #"(\d+-\d+-\d+) (\d+:\d+:\d+) (\w+) (.*)" entry))
    (raise malformed-log-entry entry)))

(def bad-log 
 ["2008-10-05 12:14:00 WARN Some warning message here..."
  "<<this is not a log message>>"
  "2008-10-05 12:14:00 INFO End of the current log..."])

(def good-log 
 ["2008-10-05 12:14:00 WARN Some warning message here..."
  "2008-10-05 12:14:00 INFO End of the current log..."])

; Example 1. Continue calculation with replacement value
(defn parse-or-nil [logseq]
  (with-handler 
    (vec (map parse-log-entry logseq))
    (handle malformed-log-entry [msg]
      (continue-with nil))))
	    
; Example 2. Continue calculation with logging & replacement value
(defn parse-or-warn [logseq]
  (with-handler 
    (vec (map parse-log-entry logseq))
    (handle malformed-log-entry [msg]
      (continue-with (println "****warning****: invalid log: " msg)))))

; Example 3. Caller can choose from a fixed set of contiue strategies.
(defn parse-or-continue [logseq]
  (let [parse-log-entry 
	(fn [entry]
	  (with-handler (parse-log-entry entry)
			(bind-continue skip [msg] nil)
			(bind-continue log [msg] (println "****warning****: invalid log: " msg))))]
    (vec (map parse-log-entry logseq))))



   


 			    