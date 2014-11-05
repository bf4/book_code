(ns mbfpp.test.oo.javabean.catsanddogslivingtogether
  (:use [mbfpp.oo.javabean.catsanddogslivingtogether])
  (:use [midje.sweet])
  (:import [mbfpp.oo.javabean.catsanddogslivingtogether NoisyCat NoisyDog]))

(fact "Cats meow"
      (let [output (java.io.StringWriter.)]
        (binding [*out* output]
          (make-noise (NoisyCat. "Tabby" "Puss")))
        (.toString output) => "Puss meows!\n"))

(fact "Dogs bark"
      (let [output (java.io.StringWriter.)]
        (binding [*out* output]
          (make-noise (NoisyDog. "Black" "Woofy")))
        (.toString output) => "Woofy barks!\n"))

