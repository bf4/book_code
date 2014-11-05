;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(defn merge [xs ys]
  (loop [acc [] xs xs ys ys]
    (match [(seq xs) (seq ys)]
      [nil b] (concat acc b)
      [a nil] (concat acc a)
      [[x & x-rest] [y & y-rest]]
        (if (< x y)
          (recur (conj acc x) x-rest ys)
          (recur (conj acc y) xs y-rest)))))


(it "implements merge (from merge-sort)"
  (should= [1 2 3] (merge [1 2 3] []))
  (should= [1 2 3] (merge [1 2 3] nil))
  (should= [1 2 3 4] (merge [1 2 3] [4]))
  (should= [1 2 3] (merge [] [1 2 3]))
  (should= [1 2 3] (merge nil [1 2 3]))
  (should= [1 2 3 4 5 6 7] (merge [1 3 4 7] [2 5 6])))

