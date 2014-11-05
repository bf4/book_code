(ns mbfpp.functional.mr.phases)

(declare plasma vapor liquid solid)

(defn plasma [[transition & rest-transitions]]
  #(case transition
     nil true
     :deionization (vapor rest-transitions)
     :false))

(defn vapor [[transition & rest-transitions]]
  #(case transition
     nil true
     :condensation (liquid rest-transitions)
     :deposition (solid rest-transitions)
     :ionization (plasma rest-transitions)
     false))

(defn liquid [[transition & rest-transitions]]
  #(case transition
     nil true
     :vaporization (vapor rest-transitions)
     :freezing (solid rest-transitions)
     false))

(defn solid [[transition & rest-transitions]]
  #(case transition
     nil true
     :melting (liquid rest-transitions)
     :sublimation (vapor rest-transitions)
     false))

(def valid-sequence [:melting :vaporization :ionization :deionization])
(def invalid-sequence [:vaporization :freezing])