#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/proc'

class ProcTests < Test::Unit::TestCase
  def test_bind_returns_method_with_changed_self
    block = Proc.new { self }
    assert_equal self, block.call
    bound_block = block.bind("hello")
    assert_not_equal block, bound_block
    assert_equal "hello", bound_block.call
  end
end