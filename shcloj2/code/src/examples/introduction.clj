;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.introduction)

(defn blank? [str]
  (every? #(Character/isWhitespace %) str))

(def accounts (ref #{}))
(defstruct account :id :balance)

(defn hello-world [username] 
  (println (format "Hello, %s" username)))  

(def fibs (lazy-cat [0 1] (map + fibs (rest fibs))))

(defn hello
  "Writes hello message to *out*. Calls you by username"
  [username]
  (println (str "Hello, " username)))
(def hello-docstring hello)

(def visitors (atom #{}))

(defn hello 
  "Writes hello message to *out*. Calls you by username.
  Knows if you have been here before."
  [username]
  (swap! visitors conj username)
  (str "Hello, " username))

(def hello-with-memory hello)