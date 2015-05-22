#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
module Logger
  extend self
  attr_accessor :output

  def log(&event)
    self.output ||= []
    event.call(output)
  end

  def play
    puts output.join("\n")
  end

end

class Thing
  def initialize(id)
    Logger.log { |output| output << "created thing #{id}" }
  end

end

def do_something
  1000.times { |i| Thing.new(i) }
end

do_something
GC.start
Logger.play
puts ObjectSpace.each_object(Thing).count
