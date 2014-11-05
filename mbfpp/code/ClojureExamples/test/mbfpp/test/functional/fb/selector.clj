(ns mbfpp.test.functional.fb.selector
  (:use [mbfpp.functional.fb.selector])
  (:use [midje.sweet]))

(fact "Selector creates functions can extract an element one level deep"
      ((selector :foo) {:foo "foo"}) => "foo")

(fact "Selector creates functions that can extract an element several levels deep"
      ((selector :foo :bar :baz) {:foo {:bar {:baz "baz"}}}) => "baz")

(fact "Selector creates functions that return nil if they don't match"
      ((selector :foo) {:bar "bar"}) => nil)