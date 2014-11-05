;---
; Excerpted from "Seven More Languages in Seven Weeks",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
;---
(ns logical.story
  (:refer-clojure :exclude [==])
  (:use clojure.core.logic
        clojure.core.logic.pldb))

;
(def story-elements
  [[:maybe-telegram-girl :telegram-girl
    "A singing telegram girl arrives."]
   [:maybe-motorist :motorist
    "A stranded motorist comes asking for help."]
   [:motorist :policeman
    "Investigating an abandoned car, a policeman appears."]
   [:motorist :dead-motorist
    "The motorist is found dead in the lounge, killed by a wrench."]
   [:telegram-girl :dead-telegram-girl
    "The telegram girl is murdered in the hall with a revolver."]
   [:policeman :dead-policeman
    "The policeman is killed in the library with a lead pipe."]
   [:dead-motorist :guilty-mustard
    "Colonel Mustard killed the motorist, his old driver during the war."]
   [:dead-motorist :guilty-scarlet
    "Miss Scarlet killed the motorist to keep her secrets safe."]
   ;; ...])
;
   [:dead-motorist :guilty-peacock
    "Mrs. Peacock killed the motorist."]
   [:dead-telegram-girl :guilty-scarlet
    "Miss Scarlet killed the telegram girl so she wouldn't talk."]
   [:dead-telegram-girl :guilty-peacock
    "Mrs. Peacock killed the telegram girl."]
   [:dead-telegram-girl :guilty-wadsworth
    "Wadsworth shot the telegram girl."]
   [:dead-policeman :guilty-scarlet
    "Miss Scarlet tried to cover her tracks by murdering the policeman."]
   [:dead-policeman :guilty-peacock
    "Mrs. Peacock killed the policeman."]
   [:mr-boddy :dead-mr-boddy
    "Mr. Boddy's body is found in the hall beaten to death with a candlestick."]
   [:dead-mr-body :guilty-plum
    "Mr. Plum killed Mr. Boddy thinking he was the real blackmailer."]
   [:dead-mr-body :guilty-scarlet
    "Miss Scarlet killed Mr. Boddy to keep him quiet."]
   [:dead-mr-body :guilty-peacock
    "Mrs. Peacock killed Mr. Boddy."]
   [:cook :dead-cook
    "The cook is found stabbed in the kitchen."]
   [:dead-cook :guilty-scarlet
    "Miss Scarlet killed the cook to silence her."]
   [:dead-cook :guilty-peacock
    "Mrs. Peacock killed her cook, who used to work for her."]
   [:yvette :dead-yvette
    "Yvette, the maid, is found strangled with the rope in the billiard room."]
   [:dead-yvette :guilty-scarlet
    "Miss Scarlet killed her old employee, Yvette."]
   [:dead-yvette :guilty-peacock
    "Mrs. Peacock killed Yvette."]
   [:dead-yvette :guilty-white
    "Mrs. White killed Yvette, who had an affair with her husband."]
   [:wadsworth :dead-wadsworth
    "Wadsworth is found shot dead in the hall."]
   [:dead-wadsworth :guilty-green
    "Mr. Green, an undercover FBI agent, shot Wadsworth."]])

;
(db-rel ploto a b)

(def story-db
  (reduce (fn [dbase elems] ;; (1)
            (apply db-fact dbase ploto (take 2 elems)))
          (db) ;; (2)
          story-elements)) ;; (3)
;

;
(def start-state
  [:maybe-telegram-girl :maybe-motorist
   :wadsworth :mr-boddy :cook :yvette])
;

;
(defn actiono [state new-state action]
  (fresh [in out temp]
    (membero in state) ;; (4)
    (ploto in out) ;; (5)
    (rembero in state temp) ;; (6)
    (conso out temp new-state) ;; (7)
    (== action [in out])))
;

;
(declare story*)

(defn storyo [end-elems actions]
  (storyo* (shuffle start-state) end-elems actions)) ;; (8)

(defn storyo* [start-state end-elems actions]
  (fresh [action new-state new-actions]
    (actiono start-state new-state action) ;; (9)
    (conso action new-actions actions) ;; (10)
    (conda
     [(everyg #(membero % new-state) end-elems) ;; (11)
      (== new-actions [])]
     [(storyo* new-state end-elems new-actions)]))) ;; (12)

;

;
(def story-map
  (reduce (fn [m elems] ;; (13)
            (assoc m (vec (take 2 elems)) (nth elems 2)))
          {}
          story-elements))

(defn print-story [actions]
  (println "PLOT SUMMARY:")
  (doseq [a actions] ;; (14)
    (println (story-map a))))
;
