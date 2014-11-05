#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
adder = Thread.new do
  # Here this thread checks its own status.
  Thread.current.status #=> 'run'
  2 * 3
end

puts adder.status #=> 'run'
adder.join
puts adder.status #=> false

