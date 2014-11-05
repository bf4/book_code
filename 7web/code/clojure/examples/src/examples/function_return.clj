(ns examples.function-return)

;
(defn keywordize [l]
  (for [elem l]
    (if (string? elem)
      (keyword elem)
      elem)))

(keywordize [1 2 "foo" 3 "bar"])
;;=> (1 2 :foo 3 :bar)
;

(def other-transform identity)
;
(keywordize (other-transform [1 2 "foo" 3 "bar"]))
;; or
(-> [1 2 "foo" 3 "bar"]
    other-transform
    keywordize)
;

;
(defn wrap-keywordize [f]
  (fn [l]
    (keywordize (f l))))
;

;
(defn wrap-keywordize-output [f]
  (fn [l]
    (keywordize (f l))))

(defn wrap-keywordize-input [f]
  (fn [l]
    (f (keywordize l))))
;

;
(defn wrap-json-response [f]
  (fn [req]
    (let [resp (f req)
          body (:body resp)]
      (assoc req :body (json/write-str body)))))
;
