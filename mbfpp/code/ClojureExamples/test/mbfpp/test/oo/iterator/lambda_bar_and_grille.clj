(ns mbfpp.test.oo.iterator.lambda-bar-and-grille
  (:use [mbfpp.oo.iterator.lambda-bar-and-grille])
  (:use [midje.sweet]))


(fact "generate-greetings generates a sequence of greetings for people in the correct zip codes"
      (generate-greetings [{:name "Mike" :address {:zip-code 19123}}
                           {:name "John" :address {:zip-code 19103}}
                           {:name "Jill" :address {:zip-code 19098}}]) =>
                          ["Hello, Mike, and welcome to the Lambda Bar And Grille!"
                           "Hello, John, and welcome to the Lambda Bar And Grille!"])
