(ns picture-gallery.views.layout
  (:require [hiccup.page :refer [html5 include-css]]
            [hiccup.element :refer [link-to]]
            [noir.session :as session]
            [hiccup.form :refer :all]))
       
(defn base [& content]
  (html5
    [:head
     [:title "Welcome to picture-gallery"]
     (include-css "/css/screen.css")]
    [:body content]))

(defn guest-menu []
  [:div (link-to "/register" "register")        
   (form-to [:post "/login"] 
            (text-field {:placeholder "screen name"} "id")
            (password-field {:placeholder "password"} "pass")
            (submit-button "login"))])
(defn user-menu [user]
  (list 
    [:div (link-to "/upload" "upload images")]
    [:div (link-to "/logout" (str "logout " user))]))
(defn common [& content]
  (base
    (if-let [user (session/get :user)] 
      (user-menu user)
      (guest-menu))
    content))
