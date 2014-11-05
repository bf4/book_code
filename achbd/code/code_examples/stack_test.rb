#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require File.join(File.dirname(__FILE__), "/stack.rb")

require 'test/unit'

class StackTest < Test::Unit::TestCase
  def setup
    @stack = Stack.new
    @stack.push :item
  end

  def test_peek_should_return_the_top_element
    assert_equal :item, @stack.peek
  end

  def test_peek_should_not_remove_the_top_element
    @stack.peek
    assert_equal 1, @stack.size
  end

  def test_pop_should_return_the_top_element
    assert_equal :item, @stack.pop
  end

  def test_pop_should_remove_the_top_element
    @stack.pop
    assert_equal 0, @stack.size
  end
end
