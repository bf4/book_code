(ns mbfpp.test.oo.iterator.higher-order-functions
  (:use [mbfpp.oo.iterator.higher-order-functions])
  (:use [midje.sweet]))

(fact "sum-sequence sums a sequence"
      (sum-sequence [42, 100, 58]) => 200)

(fact "sum-sequence doesn't allow the empty sequence"
      (sum-sequence []) => (throws AssertionError))

(fact "prepend-hello prepends hello to names"
      (prepend-hello ["Mike", "Joe", "John"]) => ["Hello, Mike", "Hello, Joe", "Hello, John"]
      (prepend-hello [] => []))

(fact "vowels-in-word returns a set of vowels in a word"
      (vowels-in-word "asdfe") => #{\a \e}
      (vowels-in-word "cfg") => #{})

