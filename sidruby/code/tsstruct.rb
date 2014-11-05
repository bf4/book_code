#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class TSStruct 
  def initialize(ts, name, struct=nil)
    @ts = ts 
    @name = name || self 
    return unless struct 
    struct.each_pair do |key, value|
      @ts.write([@name, key, value]) 
    end
  end 
  attr_reader :name
  def [](key) 
    tuple = @ts.read([name, key, nil]) 
    tuple[2]
  end
  def []=(key, value) 
    replace(key) { |old_value| value }
  end
  def replace(key) 
    tuple = @ts.take([name, key, nil]) 
    tuple[2] = yield(tuple[2])
  ensure @ts.write(tuple) if tuple
  end 
end