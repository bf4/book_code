;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(ns trptcolin.trymplicit-spec
  (:require [speclj.core :refer :all]
            [trptcolin.trymplicit :refer :all]
            [riddley.walk :as walk]))

(describe "with-implicit-try"

  (it "handles do"
      (should= :caught
               (with-implicit-try (do (throw (IllegalArgumentException. "oops"))
                                      (catch IllegalArgumentException e
                                        :caught)))))

  (it "handles old-style fn*"
    (with-implicit-try
      (should= :caught
               ((fn* hi []
                     (throw (IllegalArgumentException. "oops"))
                     (catch IllegalArgumentException e :caught))))))

  (it "handles fn macroexpansion"
    (with-implicit-try
      (should= :caught
               ((fn oh []
                  (throw (IllegalArgumentException. "oops"))
                  (catch IllegalArgumentException e :caught))))))

  (it "handles fn with a recur underneath"
    (with-implicit-try
      (should= nil
               ((fn oh [] (when false (recur)))))))

  (it "handles nested lets"
    (with-implicit-try
      (should= :rescue
               (let [x (let [y :y-val]
                         (throw (IllegalArgumentException. "oopsie"))
                         (catch Exception e :rescue))]
                 x))))

  (it "handles fn inside a let"
    (with-implicit-try
      (should= "gotcha"
               (let [i 0]
                 ((fn [] (throw (Exception. "foo"))
                    (catch Exception inner "gotcha")))
                 (catch Exception outer i)))))

  (it "handles letfn"
    (with-implicit-try
      (should= :outer-caught
               (letfn [(f1 [] (catch Exception e :inner-caught))]
                 (throw (Exception. "oops"))
                 (catch Exception e :outer-caught)))))

  (it "handles reify"
    (with-implicit-try
      (should= "caught"
               (.toString (reify Object
                            (toString [this]
                              (throw (Exception. "foobar"))
                              (catch Exception e "caught")))))))

  (it "handles when"
    (with-implicit-try
      (should= 0
               (when (< 0 5)
                 (throw (RuntimeException. "oopsie!"))
                 (catch Exception e 0)))))

  (it "handles fn* with args but no name"
    (should= 1
             (with-implicit-try
               ((fn* [] (when true 1))))))

  (it "doesn't try to wrap a try where a recur exists"
    (should=
      '(try (fn* ([] (recur))))
      (walk/macroexpand-all '(with-implicit-try
                               (fn [] (recur)))))

    (should=
      '(try (fn* ([] (try (loop* [] (recur)) (catch Exception e)))))
      (walk/macroexpand-all '(with-implicit-try
                               (fn []
                                 (loop [] (recur))
                                 (catch Exception e)))))

    ;; you cannot mix recur & implicit-try, so beware!
    (should-throw
      (eval '(with-implicit-try ((fn [x]
                                   (if (> x 5)
                                     (recur (dec x))
                                     (do
                                       (throw (Exception. "foo"))
                                       (catch Exception e :gotcha))))
                                 6))))

    (should= '(try (reify* [] (toString [this] (do (recur)))))
             (walk/macroexpand-all '(with-implicit-try
               (reify Object (toString [this] (recur))))))

    (should= nil
             (str (with-implicit-try
                    (reify Object (toString [this] (when false (recur)))))))

    (with-implicit-try
      (letfn [(x [] (recur))]))

    (with-implicit-try
      (should= :done
               (loop [i 5]
                 (if (< 0 i)
                   (recur (dec i))
                   :done))))

    )

  )
