(ns zap.views
  (:require [hiccup.page :refer [html5 include-js include-css]]
            [hiccup.form :refer [form-to text-field submit-button text-area]]
            [ring.util.response :as response]
            [zap.models :as models]
            [zap.validations :as valid]))

(defn index []
  (response/redirect "/projects"))

;
(defn base-page [title & body] ;;(1)
  (html5
   [:head
    (include-css "/css/bootstrap.min.css") ;;(2)
    (include-css "/css/zap.css")
    [:title title]]
   [:body
    [:div {:class "navbar navbar-inverse"}
     [:div {:class :navbar-inner}
      [:a {:class :brand :href "/"} "Zap!"]
      [:form {:class "navbar-form pull-right"}
       [:input {:type :text :class :search-query :placeholder :Search}]]]]

    [:div.container (seq body)]])) ;;(3)

(defn projects []
  (base-page
   "Projects - Zap"
   [:div.row.admin-bar
    [:a {:href "/projects/new"}
     "Add Project"]]
   [:h1 "Project List"]
   [:ol
    (for [p (models/all-projects)] ;;(4)
      [:li [:a {:href (str "/project/" (:id p) "/issues")} (:name p)]])]))
;

(defn new-project []
  (base-page
   "New Project - Zap"

   [:h1 "Create a new project"]

   (form-to
    {:class :form-horizontal}
    [:post "/projects"]
    (text-field :name)
    (submit-button {:class "btn btn-primary"} "Add Project"))))

(defn make-project [params]
  (models/create-project params)
  (response/redirect-after-post "/projects"))

(defn issues-by-project [id]
  (let [proj (models/project-by-id id)]
    (base-page
     (str (:name proj) " - Zap")

     [:div.row.admin-bar
      [:a {:href (str "/project/" (:id proj) "/issue/new")}
       "New Issue"]]

     [:h1 (:name proj)]

     [:table.table
      [:thead
       [:tr
        [:th.span1 {:scope :col} "#"]
        [:th.span10 {:scope :col} "Title"]
        [:th.span1 {:scope :col} "Status"]]]
      [:tbody
       (for [iss (models/issues-by-project (:id proj))]
         (let [row (fn [& content]
                     [:td
                      (into [:a {:href (str "/issue/" (:id iss))}]
                            content)])]
           [:tr
            (row (:id iss))
            (row (:title iss))
            (row (:status_name iss))]))]])))

;
(defn new-issue [id]
  (let [proj (models/project-by-id id)]
    (base-page
     (str "New Issue for " (:name proj) " - Zap")

     [:h1 "New Issue for " (:name proj)]
     (form-to
      [:post (str "/project/" (:id proj) "/issues")]
      (text-field {:class "span8"
                   :type :text
                   :placeholder "Title"} :title)
      [:br]
      (text-area {:class "span8"
                  :placeholder "Description"
                  :rows 5} :description)
      [:br]
      (submit-button {:class "btn btn-primary"} "Create Issue")))))
;

(defn issue [id]
  (let [iss (models/issue-by-id id)]
    (base-page
     (str "#" id ": " (:title iss) " - Zap")

     [:h1 "#" id ": " (:title iss)]

     [:p [:strong "Status: "] (:status_name iss)]
     [:hr]

     [:p (:description iss)]
     [:hr]

     (form-to
      {:id "close-form"}
      [:post (str "/issue/" id "/close")])
     
     (form-to
      {:id "comment-form"}
      [:post (str "/issue/" id "/comments")]
      (text-area {:class "span12"
                  :placeholder "Comment"
                  :rows 3} :comment))
     [:div.button-row
      [:button {:class "btn btn-primary"
                :form "comment-form"
                :type "submit"} "Add Comment"]
      "\n"
      (when (not= "open" (:status_name iss))
        [:button {:class "btn"
                  :form "close-form"
                  :name "close"
                  :value "open"
                  :type "submit"} "Reopen Issue"])
      "\n"
      (when (= "open" (:status_name iss))
        [:button {:class "btn"
                  :form "close-form"
                  :name "close"
                  :value "fixed"
                  :type "submit"} "Close as Fixed"])
      "\n"
      (when (= "open" (:status_name iss))
        [:button {:class "btn"
                  :form "close-form"
                  :name "close"
                  :value "wontfix"
                  :type "submit"} "Close as Won't Fix"])
      "\n"
      (when (= "open" (:status_name iss))
        [:button {:class "btn"
                  :form "close-form"
                  :name "close"
                  :value "invalid"
                  :type "submit"} "Close as Invalid"])]

     (when-let [comments (models/comments-by-issue id)]
       [:div.comments
        (for [comm comments]
          [:p.comment (:content comm)])]))))

;
(defn make-issue [id params]
  (let [iss (merge params {:project_id id :status 1})]
    (models/create-issue iss)
    (response/redirect-after-post (str "/project/" id "/issues"))))
;

(defn make-comment [id params]
  (let [comm {:issue_id id :content (:comment params)}]
    (models/create-comment comm)
    (response/redirect-after-post (str "/issue/" id))))

(defn close-issue [id params]
  (when-let [status (models/status-by-name (:close params))]
    (models/close-issue id (:id status)))
  (response/redirect-after-post (str "/issue/" id)))
