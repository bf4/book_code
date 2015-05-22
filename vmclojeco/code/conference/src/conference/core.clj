;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(ns conference.core)

(defrecord speaker
    [fname
     lname
     email
     twitter
     github
     bio
     picture-url
     ])

(defrecord timeslot
    [start  ;; Date/time - start of an instant
     length ;; Length in minutes of the timeslot
     ])
