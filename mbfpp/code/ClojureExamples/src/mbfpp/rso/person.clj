(ns mbfpp.rso.person)

(def p1 {:first-name "Michael" :last-name "Bevilacqua"})
(def p2 {:first-name "Pedro" :last-name "Vasquez"})
(def p3 {:first-name "Robert" :last-name "Aarons"})

(def people [p3 p2 p1])

(sort (fn [p1 p2] (compare (p1 :last-name) (p2 :last-name))) people)

(sort (fn [p1 p2] (compare (p1 :first-name) (p2 :first-name))) people)
