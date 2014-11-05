;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
user=> (use 'criterium.core)
user=> (defn length-1 [x] (.length x))
;=> #'user/length-1
user=> (bench (length-1 "hi there!"))
;Evaluation count : 26255400 in 60 samples of 437590 calls.
;             Execution time mean : 3.250388 µs
;    Execution time std-deviation : 850.690042 ns
;   Execution time lower quantile : 2.303419 µs ( 2.5%)
;   Execution time upper quantile : 5.038536 µs (97.5%)
;                   Overhead used : 2.193109 ns
;
;Found 1 outliers in 60 samples (1.6667 %)
;        low-severe       1 (1.6667 %)
; Variance from outliers : 94.6569 % Variance is severely inflated by outliers
;=> nil

