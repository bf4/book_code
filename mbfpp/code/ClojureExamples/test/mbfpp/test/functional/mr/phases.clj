(ns mbfpp.test.functional.mr.phases
  (:use [mbfpp.functional.mr.phases])
  (:use [midje.sweet]))

(fact "a sequence from liquid-solid-liquid-vapor-plasma-liquid is valid"
      (trampoline liquid [:freezing :melting :vaporization :ionization :deionization]) => :valid)

(fact "a sequence from liquid-plasma is invalid"
      (trampoline liquid [:ionization]) => :invalid)

(fact "the empty sequence is valid"
      (trampoline liquid []) => :valid)
                    

