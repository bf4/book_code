#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)
begin
  old_verbose = $VERBOSE
  $VERBOSE = nil
  require 'rake/contrib/sys'
ensure
  $VERBOSE = old_verbose
end

class TestSys < Rake::TestCase

  def test_split_all
    assert_equal ['a'], Sys.split_all('a')
    assert_equal ['..'], Sys.split_all('..')
    assert_equal ['/'], Sys.split_all('/')
    assert_equal ['a', 'b'], Sys.split_all('a/b')
    assert_equal ['/', 'a', 'b'], Sys.split_all('/a/b')
    assert_equal ['..', 'a', 'b'], Sys.split_all('../a/b')
  end
end
