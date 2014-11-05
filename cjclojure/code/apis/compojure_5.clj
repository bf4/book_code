;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn- compile-route
  "Compile a route in the form (method path & body) into a function."
  [method route bindings body]
  `(make-route
    ~method ~(prepare-route route)
    (fn [request#]
      (let-request [~bindings request#] ~@body))))

(defmacro GET "Generate a GET route."
  [path args & body]
  (compile-route :get path args body))

