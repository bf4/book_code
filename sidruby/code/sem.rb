#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Sem 
  include DRbUndumped 
  
  def initialize(ts, n, name=nil)
    @ts = ts
    @name = name || self 
    n.times { up }
  end 
  
  attr_reader :name
  def synchronize 
    succ = down
    yield 
  ensure
    up if succ 
  end
  
private 
  def up
    @ts.write(key) 
  end
  
  def down 
    @ts.take(key) 
    return true
  end
  
  def key 
    [@name]
  end 
end
