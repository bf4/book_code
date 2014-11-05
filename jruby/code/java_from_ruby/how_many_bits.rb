#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
java_import 'HowManyBits'

bits = HowManyBits.new

bits.needed_for 1_000_000
# => 64


bits.java_send :neededFor, [Java::int], 1_000_000
# => 32

bits_needed_for = bits.java_method :neededFor, [Java::int]
bits_needed_for.call 1_000_000
# => 32

class HowManyBits
  java_alias :needed_for_int, :neededFor, [Java::int]
end

puts bits.needed_for_int(1_000_000)
