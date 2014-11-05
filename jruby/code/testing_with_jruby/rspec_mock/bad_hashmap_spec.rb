#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import java.util.Map
java_import java.util.HashMap
java_import java.util.Iterator
java_import java.util.Set

describe HashMap do
  it 'can be created from an empty Map' do
    map = Map.new
    map.should_receive(:size).and_return(0)

    iter = Iterator.new
    iter.should_receive(:hasNext).and_return(false)

    iter.should_receive(:next)

    set = Set.new
    set.should_receive(:iterator).and_return(iter)

    map.should_receive(:entrySet).and_return(set)

    HashMap.new(map).size.should == 0
  end
end
