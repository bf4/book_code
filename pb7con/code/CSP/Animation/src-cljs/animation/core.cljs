;---
; Excerpted from "Seven Concurrency Models in Seven Weeks",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
;---
(ns animation.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [goog.dom :as dom]
            [goog.graphics :as graphics]
            [goog.events :as events]
            [cljs.core.async :refer [<! chan put! timeout]]))

(defn get-events [elem event-type]
  (let [ch (chan)]
    (events/listen elem event-type
      #(put! ch %))
    ch))

(def stroke (graphics/Stroke. 1 "#ff0000"))

(defn shrinking-circle [graphics x y]
  (go
    (let [circle (.drawCircle graphics x y 100 stroke nil)] 
      (loop [r 100]
        (<! (timeout 25)) 
        (.setRadius circle r r)
        (when (> r 0)
          (recur (dec r))))
      (.dispose circle)))) 

(defn create-graphics [elem]
  (doto (graphics/createGraphics "100%" "100%")
    (.render elem)))

(defn start []
  (let [canvas (dom/getElement "canvas")
        graphics (create-graphics canvas)
        clicks (get-events canvas "click")]
    (go (while true
          (let [click (<! clicks)
                x (.-offsetX click)
                y (.-offsetY click)]
            (shrinking-circle graphics x y))))))

(set! (.-onload js/window) start)
