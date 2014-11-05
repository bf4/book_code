#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb'
proc = Proc.new {|x| x + 1}
parent = Rinda::TupleSpace.new
DRb.start_service
child = DRbObject.new(parent)
result = 0
pid = fork do
 DRb.stop_service
 child.write([:result, proc[result]])
end
Process.detach(pid)
_, result = parent.take([:result, nil])
p result
