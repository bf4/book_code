#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'test/spec'

require 'java'

java_import java.util.HashMap

describe "an empty HashMap" do
  before :each do
    @map = HashMap.new
  end

  it "should be empty" do
    @map.isEmpty.should.be true
  end

  it "with an added entry should not be empty" do
    @map.put("hello", "world")
    @map.isEmpty.should.not.be true
  end

  it "should associate a value with a key" do
    @map.put("hello", "world")
    @map.get("hello").should.equal "world"
  end

  it "should raise error on entryset iterator next" do
    proc do
      @map.entrySet.iterator.next
    end.should.raise NativeException
  end
end
