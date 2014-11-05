;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.generator)

(import '[examples.datatypes.midi MidiNote])
(let [min-duration 250
      min-velocity 64
      rand-note (reify
  MidiNote
  (to-msec [this tempo] (+ (rand-int 1000) min-duration))
  (key-number [this] (rand-int 100))
  (play [this tempo midi-channel]
    (let [velocity (+ (rand-int 100) min-velocity)]
      (.noteOn midi-channel (key-number this) velocity)
      (Thread/sleep (to-msec this tempo)))))]
  (perform (repeat 15 rand-note)))
                                        