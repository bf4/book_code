[:ul
 (for [item items]
   [:li (:name item)])]

[:body
 [:div {:class :header}
  (include-header)]

 [:div {:class :content}
  [:h1 "Welcome!"]
  [:p "..."]]]
