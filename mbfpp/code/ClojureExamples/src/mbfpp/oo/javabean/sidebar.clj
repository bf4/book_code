(ns mbfpp.oo.javabean.sidebar)

(def cat {:type :cat 
          :color "Calico" 
          :name "Fuzzy McBootings"})

(def dog {:type :dog
          :color "Brown"
          :name "Brown Dog"})

(defmulti make-noise (fn [animal] (:type animal)))
(defmethod make-noise :cat [cat] (println (str (:name cat)) "meows!"))
(defmethod make-noise :dog [dog] (println (str (:name dog)) "barks!"))
