#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Stream 
  def initialize(ts, name)
    @ts = ts 
    @name = name 
    @tail = 0
  end 
  attr_reader :name
  def push(value) 
    @ts.write([name, @tail, value]) 
    @tail += 1
  end 
end