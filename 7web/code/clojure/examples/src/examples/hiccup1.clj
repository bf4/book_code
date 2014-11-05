(ns examples.hiccup1)

;
[:h1 "Zap Issue Tracker"]

[:div {:class :content}
 [:p "Do you have issues? Zap can help!"]
 [:p "Zap is a simple issue tracking solution ..."]]
;

;
(require '[hiccup.core :refer [html]])

(html [:h1 "Zap Issue Tracker"])
;;=> "<h1>Zap Issue Tracker</h1>"

(html
 [:div {:class :content}
  [:p "Do you have issues? Zap can help!"]
  [:p "Zap is a simple issue tracking solution ..."]])
;;=> "<div class=\"content\"><p>Do you have issues? Zap can help!</p><p>Zap is a
;;   simple issue tracking solution ...</p></div>"
;
