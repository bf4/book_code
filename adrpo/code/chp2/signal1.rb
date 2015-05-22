#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
class LargeObject
  def initialize
    @data = "x" * 1024 * 1024 * 20
  end
end

def do_something
  obj = LargeObject.new
  trap("TERM") { puts obj.inspect } 
end

do_something
# force major GC to make sure we free all objects that can be freed
GC.start(full_mark: true, immediate_sweep: true)
puts "LargeObject instances left in memory: %d" %
  ObjectSpace.each_object(LargeObject).count
