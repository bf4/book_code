#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'

arr = []
10_000.times { |i| arr << i }

10.times.map do
  Thread.new do
    loop do
      my_arr = arr.dup

      my_val = my_arr.shift
      break unless my_val
      print " #{my_val}"
    end
  end
end.each(&:join)

