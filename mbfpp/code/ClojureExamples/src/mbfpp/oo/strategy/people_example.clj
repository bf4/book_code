(ns mbfpp.oo.strategy.people-example)

(defn first-name-valid? [person]
  (not (nil? (:first-name person))))

(defn full-name-valid? [person]
  (and
    (not (nil? (:first-name person)))
    (not (nil? (:middle-name person)))
    (not (nil? (:last-name person)))))

(defn person-collector [valid?]
  (let [valid-people (atom [])]
    (fn [person]
      (if (valid? person)
        (swap! valid-people conj person))
      @valid-people)))


(def p1 {:first-name "john" :middle-name "quincy" :last-name "adams"})
(def p2 {:first-name "mike" :middle-name nil :last-name "adams"})
(def p3 {:first-name nil :middle-name nil :last-name nil})