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

require 'mocha'

RSpec.configure do |config|
  config.mock_with :mocha
end

describe HashMap do
  it 'can be created from an empty Map' do
    map = Map.new
    map.expects(:size).returns(0)

    iter = Iterator.new
    iter.expects(:hasNext).returns(false)

    set = Set.new
    set.expects(:iterator).returns(iter)

    map.expects(:entrySet).returns(set)

    HashMap.new(map).size.should == 0
  end
end
