(ns picture-gallery.views.layout
  (:require [hiccup.page :refer [html5 include-css]]
            [hiccup.element :refer [link-to]]
            [noir.session :as session]
            [hiccup.form :refer :all]
            [hiccup.page :refer [include-css include-js]]
            [ring.util.response :refer [content-type response]]
            [compojure.response :refer [Renderable]]))

(defn utf-8-response [html]
  (content-type (response html) "text/html; charset=utf-8"))

(deftype RenderablePage [content]
  Renderable
  (render [this request]
    (utf-8-response
      (html5
        [:head
         [:title "Welcome to picture-gallery"]
         (include-css "/css/screen.css")
         [:script {:type "text/javascript"} 
          (str "var context=\"" (:context request) "\";")]
         (include-js "//code.jquery.com/jquery-2.0.2.min.js")]
        [:body content]))))

(defn base [& content]
  (RenderablePage. content))

(defn make-menu [& items]
  [:div (for [item items] [:div.menuitem item])])

(defn guest-menu []
  (make-menu
   (link-to "/" "home")
   (link-to "/register" "register")
   (form-to [:post "/login"] 
            (text-field {:placeholder "screen name"} "id")
            (password-field {:placeholder "password"} "pass")
            (submit-button "login"))))

(defn user-menu [user]
  (make-menu 
    (link-to "/" "home")
    (link-to "/upload" "upload images")
    (link-to "/logout" (str "logout " user))))

(defn common [& content]
  (base    
    (if-let [user (session/get :user)]
      (user-menu user)      
      (guest-menu))
    [:div.content content]))
