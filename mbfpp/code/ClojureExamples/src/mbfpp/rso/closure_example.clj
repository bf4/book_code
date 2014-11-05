(ns mbfpp.rso.closure-example)

; Scope 1 - Top Level
(def foo "first foo")
(def bar "first bar")
(def baz "first baz")

(defn make-printer [foo bar] ; Scope 2 - Function Arguments
  (fn []
    (let [foo "third foo"] ; Scope 3 - Let Statement
      (println foo)
      (println bar)
      (println baz))))

