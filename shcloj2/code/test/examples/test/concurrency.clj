;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.concurrency
  (:use clojure.test
        examples.concurrency
        [clojure.java.io :only (reader)])
  (:require [examples.chat :as chat]))

(deftest test-next-counter
  (dosync (ref-set counter 0))
  (is (= (next-counter) 1)))

(deftest test-slow-double
  (is (= [2 4 2 4 2 4] (calls-slow-double))))

(deftest test-demos
  (let [out-str (with-out-str (demo-memoize))]
    (is (re-find #"Elapsed time: \d+\.\d+ msecs" out-str)
	out-str)))
  
(deftest test-add-message-with-backup
  (let [msg (chat/->Message "unit test" "test message")]
    (.delete (java.io.File. "output/messages-backup.clj"))
    (dosync (ref-set chat/messages ()))
    (add-message-with-backup msg)
    (await backup-agent)
    (is (= (read (java.io.PushbackReader. (reader "output/messages-backup.clj")))
	   (list msg)))))