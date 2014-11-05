#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'shoulda'
require 'java'

java_import java.util.HashMap
java_import java.util.TreeMap
java_import java.util.concurrent.ConcurrentHashMap

module MapMacros
  def should_behave_as_a_map
    # Everything inside the "New hashmap" context from before,
    # *except* the first "setup" block and the outermost pair of
    # "context ... end" lines
  end

  def self.included(type)
    type.extend self
  end
end

module MapMacros
  def should_behave_as_a_map
    should "be empty" do
      assert @map.isEmpty
    end

    should "raise error on entryset iterator next" do
      assert_raises(NativeException) do
        @map.entrySet.iterator.next
      end
    end

    context "with one entry" do
      setup do
        @map.put("hello", "world")
      end

      should "not be empty" do
        assert !@map.isEmpty
      end

      should "have size one" do
        assert_equal 1, @map.size
      end

      should "associate a value with a key" do
        assert_equal "world", @map.get("hello")
      end
    end
  end
end

class MapTestCase < Test::Unit::TestCase
  include MapMacros

  context "new HashMap" do
    setup { @map = HashMap.new }
    should_behave_as_a_map
  end

  context "new TreeMap" do
    setup { @map = TreeMap.new }
    should_behave_as_a_map
  end

  context "new ConcurrentHashMap" do
    setup { @map = ConcurrentHashMap.new }
    should_behave_as_a_map
  end
end
