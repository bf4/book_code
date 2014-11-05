(ns mbfpp.test.functional.tr.names
  (:use [mbfpp.functional.tr.names])
  (:use [midje.sweet]))

(fact "Make people makes people from sequences of first and last names."
      (make-people ["firstone" "firsttwo"] ["lastone" "lasttwo"]) => 
                   [{:first "firstone" :last "lastone"}
                    {:first "firsttwo" :last "lasttwo"}])

(fact "Make people and shorter make people workd the same."
      (make-people ["firstone" "firsttwo"] ["lastone" "lasttwo"]) => 
      (shorter-make-people ["firstone" "firsttwo"] ["lastone" "lasttwo"]))