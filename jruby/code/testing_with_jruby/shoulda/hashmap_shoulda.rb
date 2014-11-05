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

class HashMapTestCase < Test::Unit::TestCase
  context "New hashmap" do
    setup do
      @map = HashMap.new
    end

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
