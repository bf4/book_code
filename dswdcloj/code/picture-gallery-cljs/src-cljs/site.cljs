(ns site
  (:require [domina :refer [by-class nodes sel attr]]    
            [domina.css :refer [sel]]))

(defn rgb-str [[r g b]]
  (str "rgb(" r "," g "," b ")"))

(defn set-color [style foreground background]
  (set! (.-color style) (rgb-str foreground))
  (set! (.-backgroundColor style) (rgb-str background)))

(defn img-url [div]   
  (-> div (sel "img") (attr "src")))

(defn set-colors [div]
  (.getColors (js/AlbumColors. (img-url div)) 
    (fn [[background _ foreground]] 
      (set-color (.-style div) foreground background))))

(defn ^:export init [] 
  (doseq [div (nodes (by-class "thumbnail"))]  
    (set-colors div)))

