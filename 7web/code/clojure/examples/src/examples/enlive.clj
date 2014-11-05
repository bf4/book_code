(ns examples.enlive
  (:use net.cgrand.enlive-html))

;
(use 'net.cgrand.enlive-html)

(deftemplate page-with-title "templates/projects.html"
  [title]

  [:title] (content (str title " - Zap")))
;

;
(defsnippet project-item
  "templates/projects.html" [:.container :ol [:li first-child]] ;;(1)
  [proj]

  [:a] (do-> ;;(2)
        (set-attr :href (str "/project/" (:id proj) "/issues"))
        (content (:name proj))))
;

(defsnippet admin-bar
  "templates/projects.html" [:.container :.admin-bar]
  [links]

  [:a] (do->
        (clone-for [[url title] links]
                   (do->
                    (set-attr :href url)
                    (content title)))
        (wrap :ol)))
