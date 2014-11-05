#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class String
  def method_missing(method, *args)
    method == :ghost_reverse ? reverse : super
  end
end

require 'benchmark'

Benchmark.bm do |b|
  b.report 'Normal method' do
    1000000.times { "abc".reverse }
  end
  b.report 'Ghost method ' do
    1000000.times { "abc".ghost_reverse }
  end
end
