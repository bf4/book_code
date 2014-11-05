(require '[clojure.data.json :as json])
(json/write-str {:foo 1 :bar 2})
;;=> "{\"foo\":1,\"bar\":2}"

(json/read-str "{\"foo\":1,\"bar\":2}")
;;=> {:foo 1 :bar 2}
