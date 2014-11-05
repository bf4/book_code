#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'rinda/tuplespace'
require 'rinda/eval'

def fib(n)
  n < 2 ? n : fib(n - 2) + fib(n - 1)
end

def fib_daemon(place)
  Rinda::rinda_eval(place) do |ts|
    begin
      while true
        _, n = ts.take([:fib, Integer])
        ts.write([:fib_ans, n, fib(n)])
      end
      [:done]  # not reached
    rescue DRb::DRbConnError
      exit(0)
    end
  end
end

place = Rinda::TupleSpace.new
DRb.start_service

2.times { fib_daemon(place) }

[30, 20, 10, 30].each {|x|
  place.write([:fib, x])
}.each {|x|
  p place.take([:fib_ans, x, nil])
}
