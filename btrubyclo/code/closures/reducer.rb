#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
reducer = lambda do |acc, arr, binary_function|
  reducer_aux = lambda do |acc, arr| 
    if arr.empty?
      acc
    else
      reducer_aux.call(binary_function.call(acc, arr.first), arr.drop(1))
    end
  end

  reducer_aux.call(acc, arr)
end

reducer.call(1, [1,2,3,4,5], lambda { |x, y| x + y }) #=> 16
