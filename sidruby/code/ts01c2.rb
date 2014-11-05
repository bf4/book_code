#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'

def fact_client(ts, a, b, n=1000)
  req = []
  a.step(b, n) { |head|
    tail = [b, head + n - 1].min
    req.push([head, tail])
    ts.write(['fact', head, tail])
  }

  req.inject(1) { |value, range|
    tuple = ts.take(['fact-answer', range[0], range[1], nil])
    value * tuple[3]
  }
end

ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
# p fact_client($ts, 1, 20000)
fact_client($ts, 1, 20000)