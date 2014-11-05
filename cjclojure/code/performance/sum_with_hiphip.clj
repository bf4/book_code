;---
; Excerpted from "Mastering Clojure Macros",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
;---
(require 'hiphip.int)
(bench (hiphip.int/asum array))
;             Execution time mean : 144.535507 ns
;    Execution time std-deviation : 1.587751 ns
