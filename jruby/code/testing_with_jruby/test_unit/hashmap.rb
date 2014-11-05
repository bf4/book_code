#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'test/unit'

require 'java'

java_import java.util.HashMap

class HashMapTestCase < Test::Unit::TestCase
  def setup
    @map = HashMap.new
  end

  def test_new_hashmap_is_empty
    assert @map.isEmpty
  end

  def test_hashmap_with_entry_is_not_empty
    @map.put("hello", "world")
    assert !@map.isEmpty
  end

  def test_value_is_associated_with_added_key
    @map.put("hello", "world")
    assert_equal "world", @map.get("hello")
  end

  def test_entry_set_iterator_next_raises_error_for_empty_hashmap
    assert_raises(NativeException) do
      @map.entrySet.iterator.next
    end
  end
end
