;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.test.chat
  (:use clojure.test)
  (:require [examples.chat :as c]))

(deftest naive-add-message
  (dosync (ref-set c/messages ()))
  (c/naive-add-message (c/->Message "jdoe" "hello"))
  (is (= [#examples.chat.Message{:sender "jdoe" :text "hello"}]
         @c/messages)))

(deftest add-message
  (dosync (ref-set c/messages ()))
  (c/add-message (c/->Message "jdoe" "goodbye"))
  (is (= [#examples.chat.Message{:sender "jdoe" :text "goodbye"}]
         @c/messages)))

(deftest add-message-commute
  (dosync (ref-set c/messages ()))
  (c/add-message-commute (c/->Message "jdoe" "goodbye"))
  (is (= [#examples.chat.Message{:sender "jdoe" :text "goodbye"}]
         @c/messages)))

(deftest validate-message-list
  (is (true? (c/validate-message-list ())))
  (is (true? (c/validate-message-list '({:sender "X" :text "Y"}))))
  (is (false? (c/validate-message-list '({})))))
