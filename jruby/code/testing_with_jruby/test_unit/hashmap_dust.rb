#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'test/unit'
require 'rubygems'
require 'dust'

require 'java'

java_import java.util.HashMap

unit_tests do
  def setup
    @map = HashMap.new
  end

  test "new hashmap is empty" do
    assert @map.isEmpty
  end

  test "hashmap with entry is not empty" do
    @map.put("hello", "world")
    assert !@map.isEmpty
  end

  test "value is associated with added key" do
    @map.put("hello", "world")
    assert_equal "world", @map.get("hello")
  end

  test "entryset iterator next raises error for empty hashmap" do
    assert_raises(NativeException) do
      @map.entrySet.iterator.next
    end
  end
end
