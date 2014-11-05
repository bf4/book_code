;---
; Excerpted from "Seven Concurrency Models in Seven Weeks",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
;---
(ns wizard.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [goog.dom :as dom]
            [goog.events :as events]
            [cljs.core.async :refer [chan put!]]))

(defn show [elem]
  (set! (.. elem -style -display) "block"))

(defn hide [elem]
  (set! (.. elem -style -display) "none"))

(defn set-value [elem value]
  (set! (.-value elem) value))

(defn get-events [elem event-type]
  (let [ch (chan)]
    (events/listen elem event-type
      #(put! ch %))
    ch))

(defn start []
  (go
    (let [wizard (dom/getElement "wizard")
          step1 (dom/getElement "step1")
          step2 (dom/getElement "step2")
          step3 (dom/getElement "step3")
          next-button (dom/getElement "next")
          next-clicks (get-events next-button "click")] 
      (show step1)
      (<! next-clicks) 
      (hide step1)
      (show step2)
      (<! next-clicks)
      (set-value next-button "Finish")
      (hide step2)
      (show step3)
      (<! next-clicks)
      (.submit wizard)))) 

(set! (.-onload js/window) start)
