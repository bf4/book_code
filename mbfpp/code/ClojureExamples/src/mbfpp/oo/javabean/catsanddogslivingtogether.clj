(ns mbfpp.oo.javabean.catsanddogslivingtogether)

(defrecord Cat [color name])

(defrecord Dog [color name])

(defprotocol NoiseMaker
  (make-noise [this]))

(defrecord NoisyCat [color name]
  NoiseMaker
  (make-noise [this] (str (:name this) " meows!")))

(defrecord NoisyDog [color name]
  NoiseMaker
  (make-noise [this] (str (:name this) " barks!")))
