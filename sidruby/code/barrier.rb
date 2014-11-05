#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Barrier 
  def initialize(ts, n, name=nil)
    @ts = ts 
    @name = name || self 
    @ts.write([key, n])
  end 
  def key
    @name 
  end
end
