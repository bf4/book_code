#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'hamster/vector'

mutable = Array.new
immutable = Hamster::Vector.new

mutable #=> []
mutable.push(nil)
mutable #=> [nil]

immutable #=> []
immutable.add(nil) #=> [nil]
immutable #=> []

# This is typical of immutable data structures,
# re-assign the reference to the result of an
# operation.
immutable = immutable.add(nil)
immutable #=> [nil]

