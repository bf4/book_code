;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(def recur-found (atom false))

(defn should-transform? [x]
  (and (seq? x)
       ;; NOTE: we've added 'recur - easy to forget
       (#{'recur 'fn* 'do 'loop* 'let* 'letfn* 'reify*} (first x))))

(defn transform [x]
  (condp = (first x)
    'recur (let [[verb & args] x]
             (reset! recur-found true)
             x)
    ;; ...
    'fn* (let [[verb & fn-decl] x
               _ (reset! recur-found false)
               result `(fn* ~@(doall (wrap-fn-decl fn-decl)))]
           (if @recur-found
             x
             result))
    ;; ...
))
