(ns zap.validations)

(defn valid-project? [params]
  (when-let [name (:name params)]
    (pos? (count name))))
