#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'thread'
class SemQ 
  def initialize(n)
    @queue = Queue.new
    n.times { up }
  end 
  
  def synchronize 
    succ = down
    yield
    up if succ 
  end
  
private 
  def up
    @queue.push(true) 
  end
  def down 
    @queue.pop
  end
end