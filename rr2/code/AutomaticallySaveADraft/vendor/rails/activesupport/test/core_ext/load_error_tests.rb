#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/load_error'

class TestMissingSourceFile < Test::Unit::TestCase
  def test_with_require
    assert_raises(MissingSourceFile) { require 'no_this_file_don\'t_exist' }
  end
  def test_with_load
    assert_raises(MissingSourceFile) { load 'nor_does_this_one' }
  end
  def test_path
    begin load 'nor/this/one.rb'
    rescue MissingSourceFile => e
      assert_equal 'nor/this/one.rb', e.path
    end
  end
end