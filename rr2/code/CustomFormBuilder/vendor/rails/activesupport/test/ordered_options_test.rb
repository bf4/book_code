#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'

require File.dirname(__FILE__) + '/../lib/active_support/ordered_options'

class OrderedOptionsTest < Test::Unit::TestCase
  def test_usage
    a = OrderedOptions.new

    assert_nil a[:not_set]

    a[:allow_concurreny] = true    
    assert_equal 1, a.size
    assert a[:allow_concurreny]

    a[:allow_concurreny] = false
    assert_equal 1, a.size
    assert !a[:allow_concurreny]

    a["else_where"] = 56
    assert_equal 2, a.size
    assert_equal 56, a[:else_where]
  end
  
  def test_looping
    a = OrderedOptions.new

    a[:allow_concurreny] = true    
    a["else_where"] = 56
    
    test = [[:allow_concurreny, true], [:else_where, 56]]
    
    a.each_with_index do |(key, value), index|
      assert_equal test[index].first, key
      assert_equal test[index].last, value
    end
  end
  
  def test_method_access
    a = OrderedOptions.new

    assert_nil a.not_set

    a.allow_concurreny = true    
    assert_equal 1, a.size
    assert a.allow_concurreny

    a.allow_concurreny = false
    assert_equal 1, a.size
    assert !a.allow_concurreny

    a.else_where = 56
    assert_equal 2, a.size
    assert_equal 56, a.else_where
  end
end
