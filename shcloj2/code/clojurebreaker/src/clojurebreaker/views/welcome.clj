;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns clojurebreaker.views.welcome
  (:require [noir.session :as session]
            [clojurebreaker.views.common :as common]
            [clojurebreaker.models.game :as game])
  (:use [noir.core :only (defpartial defpage render)]
        [hiccup.form-helpers :only (form-to text-field submit-button)]))

(defpartial board [{:keys [one two three four exact unordered]}]
  (when (and exact unordered)
    [:div "Exact: " exact " Unordered: " unordered])
  (form-to [:post "/guess"]
           (text-field "one" one)
           (text-field "two" two)
           (text-field "three" three)
           (text-field "four" four)
           (submit-button "Guess")))

(defpage "/" {:as guesses} 
  (when-not (session/get :game)
    (session/put! :game (game/create)))
  (common/layout (board (or guesses nil))))

(defpage [:post "/guess"] {:keys [one two three four]}
  (let [result (game/score (session/get :game) [one two three four])]
    (if (= (:exact result) 4)
      (do (session/remove! :game)
          (common/layout
           [:h2 "Congratulations, you have solved the puzzle!"]
           (form-to [:get "/"]
                    (submit-button "Start A New Game"))))
      (do (session/flash-put! result)
          (render "/" {:one one
                       :two two
                       :three three
                       :four four
                       :exact (:exact result)
                       :unordered (:unordered result)})))))
