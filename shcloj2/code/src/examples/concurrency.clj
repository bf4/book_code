;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.concurrency
  (:use examples.chat))

(def counter (ref 0))

(defn next-counter [] (dosync (alter counter inc)))

(defn ^:dynamic slow-double [n]
  (Thread/sleep 100)
  (* n 2))

(defn calls-slow-double []
  (map slow-double [1 2 1 2 1 2]))

(defn demo-memoize []
  (time 
   (dorun
    (binding [slow-double (memoize slow-double)]
      (calls-slow-double)))))

(def backup-agent (agent "output/messages-backup.clj"))

(defn add-message-with-backup [msg]
  (dosync 
   (let [snapshot (commute messages conj msg)]
     (send-off backup-agent (fn [filename]
			      (spit filename snapshot)
			      filename))
     snapshot)))

  
