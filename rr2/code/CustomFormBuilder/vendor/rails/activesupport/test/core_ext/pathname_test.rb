#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/pathname'

class TestPathname < Test::Unit::TestCase
  
  def test_clean_within
    assert_equal "Hi", Pathname.clean_within("Hi")
    assert_equal "Hi", Pathname.clean_within("Hi/a/b/../..")
    assert_equal "Hello\nWorld", Pathname.clean_within("Hello/a/b/../..\na/b/../../World/c/..")
  end
  
end
