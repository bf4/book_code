;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns trptcolin.trymplicit
  (:require [riddley.walk :as walk]))

(def ^:dynamic *recur-search-tracker*
  (atom false))

(declare add-try)

(defn should-transform? [x]
  (and (seq? x)
       (#{'fn* 'do 'loop* 'let* 'letfn* 'reify* 'recur} (first x))))

(defn- wrap-fn-body [wrapper-fn [bindings & body]]
  (if (nil? wrapper-fn)
    (cons bindings body)
    (list bindings (wrapper-fn body))))

(defn- wrap-bindings [bindings]
  (->> bindings
       (partition-all 2)
       (mapcat
         (fn [[k v]]
           (let [[k v] [k (add-try v)]]
             [k v])))
       vec))

(defn- wrap-fn-decl [wrapper-fn clauses]
  (let [[name? args? fn-bodies]
          (cond (symbol? (first clauses))
                  (if (vector? (second clauses))
                    [(first clauses) (second clauses) (drop 2 clauses)]
                    [(first clauses) nil
                     (doall (map (partial wrap-fn-body wrapper-fn)
                                 (rest clauses)))])
                (vector? (first clauses))
                  [nil (first clauses) (rest clauses)]
                :else
                  [nil nil (doall (map (partial wrap-fn-body wrapper-fn)
                                       clauses))])]
    (cond->> fn-bodies
      (and name? args?) (#(if (nil? wrapper-fn)
                            (list `(do ~@(doall (map add-try %))))
                            (list (wrapper-fn (doall (map add-try %))))))
      (not (and name? args?)) (#(let [not-both-result (map add-try %)]
                                  not-both-result))
      args? (cons args?)
      name? (cons name?))))

(defn- wrap-let-like [expression]
  (let [[verb bindings & body] expression
        result `(~verb ~(wrap-bindings bindings) (try ~@(doall (add-try body))))]
    (if @*recur-search-tracker*
      `(~verb ~(wrap-bindings bindings) ~@(add-try body))
      result)))

(defn transform [x]
  (condp = (first x)

    'recur (let [[verb & args] x]
             (reset! *recur-search-tracker* true)
             x)

    'do (let [[_ & body] x
              result (cons 'try (add-try body))]
          (if @*recur-search-tracker*
            (cons 'do (add-try body))
            (cons 'try (add-try body))))

    'loop* (binding [*recur-search-tracker* (atom false)]
             (wrap-let-like x))

    'let* (wrap-let-like x)

    'letfn* (wrap-let-like x)

    'fn* (binding [*recur-search-tracker* (atom false)]
           (let [[verb & fn-decl] x
                 result `(fn* ~@(doall (wrap-fn-decl #(cons 'try %) fn-decl)))]
             (if @*recur-search-tracker*
               `(fn* ~@(doall (wrap-fn-decl nil fn-decl)))
               result)))

    'reify* (let [[verb options & fn-decls] x
                  wrap-reify-fn (fn [expression]
                                  (binding [*recur-search-tracker* (atom false)]
                                    (let [result (doall (wrap-fn-decl #(cons 'try %)
                                                                      expression))]
                                      (if @*recur-search-tracker*
                                        (wrap-fn-decl nil expression)
                                        result))))]
              `(~verb ~options ~@(doall (map wrap-reify-fn fn-decls))))

    x))

(defn add-try [expression]
  (walk/walk-exprs should-transform? transform expression))

(defmacro with-implicit-try [& body]
  (cons 'try (map #(binding [*recur-search-tracker* (atom false)] (add-try %))
                  body)))

