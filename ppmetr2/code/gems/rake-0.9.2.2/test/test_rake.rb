#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRake < Rake::TestCase
  def test_each_dir_parent
    assert_equal ['a'], alldirs('a')
    assert_equal ['a/b', 'a'], alldirs('a/b')
    assert_equal ['/a/b', '/a', '/'], alldirs('/a/b')
    if File.dirname("c:/foo") == "c:"
      # Under Unix
      assert_equal ['c:/a/b', 'c:/a', 'c:'], alldirs('c:/a/b')
      assert_equal ['c:a/b', 'c:a'], alldirs('c:a/b')
    else
      # Under Windows
      assert_equal ['c:/a/b', 'c:/a', 'c:/'], alldirs('c:/a/b')
      assert_equal ['c:a/b', 'c:a'], alldirs('c:a/b')
    end
  end

  def alldirs(fn)
    result = []
    Rake.each_dir_parent(fn) { |d| result << d }
    result
  end

  def test_can_override_application
    old_app = Rake.application
    fake_app = Object.new
    Rake.application = fake_app

    assert_equal fake_app, Rake.application

  ensure
    Rake.application = old_app
  end

  def test_original_dir_reports_current_dir
    assert_equal @tempdir, Rake.original_dir
  end

end
