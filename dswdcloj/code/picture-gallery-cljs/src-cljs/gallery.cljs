(ns gallery
  (:require [goog.dom :as dom]
            [domina :refer [by-id nodes append!]]
            [domina.events :refer [listen!]]
            [domina.css :refer [sel]]
            [ajax.core :refer [POST]]))

(defn handle-response [response]
  (let [errors (goog.string.StringBuffer. "")]
    (doseq [{:keys [name status]} response]
      (if (= "ok" status)
        (-> (by-id name)
            (.-parentNode)
            (.-parentNode)
            (dom/removeNode))
        (.append errors (str "<li>failed to remove " name ": " status "</li>"))))
		
    (when-let [error-str (not-empty (.toString errors))]
      (append! (by-id "error") (str "<ul>" error-str "</ul>")))))
(defn find-selected []
  (->> (sel "input:checked")
       nodes
       (map #(.-name %))
       not-empty))

(defn deleteImages [_]
  (if-let [selected (find-selected)]
    (POST "/delete" {:params {:names selected}
                     :handler handle-response})
    (js/alert "no images selected")))

(defn ^:export init []
  (listen! (by-id "delete") :click deleteImages))
