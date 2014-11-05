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
  # Earlier Ruby had a slower implementation.
  if RUBY_VERSION < '1.8.7'
    remove_method :realtime

    def realtime
      r0 = Time.now
      yield
      r1 = Time.now
      r1.to_f - r0.to_f
    end
  end

  def ms
    1000 * realtime { yield }
  end
end
