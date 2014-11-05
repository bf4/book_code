(ns examples.valip)

;
(require '[valip.core :refer [validate]]
         '[valip.predicates :refer [present? min-length])
    
(defn valid-project [proj]
  (validate proj
    [:name present? "name must be specified"]
    [:name (min-length 1) "name must not be blank"]))
;

;
(defn min-length
  "Creates a predicate that returns true if a string's length is greater than
          or equal to the supplied minimum."
  [min]
  (fn [s] (>= (count s) min)))
;
