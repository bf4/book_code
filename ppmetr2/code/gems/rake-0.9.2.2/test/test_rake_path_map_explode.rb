#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakePathMapExplode < Rake::TestCase
  def setup
    super

    String.class_eval { public :pathmap_explode }
  end

  def teardown
    String.class_eval { protected :pathmap_explode }

    super
  end

  def test_explode
    assert_equal ['a'], 'a'.pathmap_explode
    assert_equal ['a', 'b'], 'a/b'.pathmap_explode
    assert_equal ['a', 'b', 'c'], 'a/b/c'.pathmap_explode
    assert_equal ['/', 'a'], '/a'.pathmap_explode
    assert_equal ['/', 'a', 'b'], '/a/b'.pathmap_explode
    assert_equal ['/', 'a', 'b', 'c'], '/a/b/c'.pathmap_explode

    if File::ALT_SEPARATOR
      assert_equal ['c:.', 'a'], 'c:a'.pathmap_explode
      assert_equal ['c:.', 'a', 'b'], 'c:a/b'.pathmap_explode
      assert_equal ['c:.', 'a', 'b', 'c'], 'c:a/b/c'.pathmap_explode
      assert_equal ['c:/', 'a'], 'c:/a'.pathmap_explode
      assert_equal ['c:/', 'a', 'b'], 'c:/a/b'.pathmap_explode
      assert_equal ['c:/', 'a', 'b', 'c'], 'c:/a/b/c'.pathmap_explode
    end
  end
end

