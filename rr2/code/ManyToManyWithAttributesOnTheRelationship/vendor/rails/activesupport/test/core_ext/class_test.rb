#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/class'

class A
end

module X
  class B
  end
end

module Y
  module Z
    class C
    end
  end
end

class ClassTest < Test::Unit::TestCase
  def test_removing_class_in_root_namespace
    assert A.is_a?(Class)
    Class.remove_class(A)
    assert_raises(NameError) { A.is_a?(Class) }
  end

  def test_removing_class_in_one_level_namespace
    assert X::B.is_a?(Class)
    Class.remove_class(X::B)
    assert_raises(NameError) { X::B.is_a?(Class) }
  end

  def test_removing_class_in_two_level_namespace
    assert Y::Z::C.is_a?(Class)
    Class.remove_class(Y::Z::C)
    assert_raises(NameError) { Y::Z::C.is_a?(Class) }
  end
end
