#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakePathMapPartial < Rake::TestCase
  def test_pathmap_partial
    @path = "1/2/file"
    def @path.call(n)
      pathmap_partial(n)
    end
    assert_equal("1", @path.call(1))
    assert_equal("1/2", @path.call(2))
    assert_equal("1/2", @path.call(3))
    assert_equal(".", @path.call(0))
    assert_equal("2", @path.call(-1))
    assert_equal("1/2", @path.call(-2))
    assert_equal("1/2", @path.call(-3))
  end
end

