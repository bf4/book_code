(ns mbfpp.functional.di.examples)

(defn get-movie [movie-id]
  {:id "42" :title "A Movie"})

(defn get-favorite-videos [user-id]
  [{:id "1"}])

(defn get-favorite-decorated-videos [user-id get-movie get-favorite-videos]
  (for [video (get-favorite-videos user-id)]
    {:movie (get-movie (:id video))
     :video video}))

(defn get-test-movie [movie-id]
  {:id "43" :title "A Test Movie"})

(defn get-test-favorite-videos [user-id]
  [{:id "2"}])

(defn get-favorite-decorated-videos-2 [user-id]
  (for [video (get-favorite-videos user-id)]
    {:movie (get-movie (:id video))
     :video video}))

(with-redefs
  [get-favorite-videos get-test-favorite-videos
   get-movie get-test-movie]
  (doall (get-favorite-decorated-videos-2 "2")))

(defn dep [] "dep")

(defn test-dep [] "test-dep")

(defn outer-1 []
  (conj (for [foo (range 0 1)] (dep)) (dep)))

(defn outer-2 []
  (for [foo (range 0 1)] (dep)))