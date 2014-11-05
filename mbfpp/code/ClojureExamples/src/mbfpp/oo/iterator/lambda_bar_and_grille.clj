(ns mbfpp.oo.iterator.lambda-bar-and-grille)

(def close-zip? #{19123 19103})

(defn generate-greetings [people]
  (for [{:keys [name address]} people :when (close-zip? (address :zip-code))]
    (str "Hello, " name ", and welcome to the Lambda Bar And Grille!")))

(defn print-greetings [people]
  (doseq [{:keys [name address]} people :when (close-zip? (address :zip-code))]
    (println (str "Hello, " name ", and welcome to the Lambda Bar And Grille!"))))
