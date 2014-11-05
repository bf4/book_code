(ns mbfpp.test.functional.fb.composition-examples
  (:use [mbfpp.functional.fb.composition-examples])
  (:use [midje.sweet]))

(fact "Append cba appends cba to a string" 
      (append-cba "foo") => "foocba")

(fact "Check authorization assumes any non-nil Authorization header is valid"
      (let [output (java.io.StringWriter.)]
        (binding [*out* output]
          (check-authorization request) => request)
        (.toString output) => "Valid authorization.\n"))

(fact "Check authorization assumes any nil Authorization header is invalid"
      (let [output (java.io.StringWriter.)]
        (binding [*out* output]
          (check-authorization {}) => {})
        (.toString output) => "No auth header!\n"))

(fact "Log fingerprint logs a fingerprint to stdout."
      (let [output (java.io.StringWriter.)]
        (binding [*out* output]
          (log-fingerprint request) => request)
        (.toString output) => "FINGERPRINT=fingerprint\n"))

(fact "Compose filters composes filters together."
      (let [filter-one (fn [r] (assoc r :header-one "header one"))
            filter-two (fn [r] (assoc r :header-two "header two"))
            composed (compose-filters [filter-one filter-two])]
        (composed {}) => {:header-one "header one" :header-two "header two"}))