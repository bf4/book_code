#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakeRequire < Rake::TestCase

  def test_can_load_rake_library
    rakefile_rakelib
    app = Rake::Application.new

    assert app.instance_eval {
      rake_require("test2", ['rakelib'], [])
    }
  end

  def test_wont_reload_rake_library
    rakefile_rakelib
    app = Rake::Application.new

    paths = ['rakelib']
    loaded_files = []
    app.rake_require("test2", paths, loaded_files)

    assert ! app.instance_eval {
      rake_require("test2", paths, loaded_files)
    }
  end

  def test_throws_error_if_library_not_found
    rakefile_rakelib

    app = Rake::Application.new
    ex = assert_raises(LoadError) {
      assert app.instance_eval {
        rake_require("testx", ['rakelib'], [])
      }
    }
    assert_match(/(can *not|can't)\s+find/i, ex.message)
    assert_match(/testx/, ex.message)
  end
end

