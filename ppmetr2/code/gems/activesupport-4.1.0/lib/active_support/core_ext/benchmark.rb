#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'benchmark'

class << Benchmark
  # Benchmark realtime in milliseconds.
  #
  #   Benchmark.realtime { User.all }
  #   # => 8.0e-05
  #
  #   Benchmark.ms { User.all }
  #   # => 0.074
  def ms
    1000 * realtime { yield }
  end
end
