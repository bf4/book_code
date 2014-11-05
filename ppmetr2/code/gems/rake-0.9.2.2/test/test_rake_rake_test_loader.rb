#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakeRakeTestLoader < Rake::TestCase

  def test_pattern
    orig_LOADED_FEATURES = $:.dup
    FileUtils.touch 'foo.rb'
    FileUtils.touch 'test_a.rb'
    FileUtils.touch 'test_b.rb'

    ARGV.replace %w[foo.rb test_*.rb -v]

    load File.join(@orig_PWD, 'lib/rake/rake_test_loader.rb')

    assert_equal %w[-v], ARGV
  ensure
    $:.replace orig_LOADED_FEATURES
  end

end

