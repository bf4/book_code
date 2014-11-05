#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakeTaskManagerArgumentResolution < Rake::TestCase

  def setup
    super

    Rake.application.options.ignore_deprecate = true
  end

  def teardown
    Rake.application.options.ignore_deprecate = false

    super
  end

  def test_good_arg_patterns
    assert_equal [:t, [], []],       task(:t)
    assert_equal [:t, [], [:x]],     task(:t => :x)
    assert_equal [:t, [], [:x, :y]], task(:t => [:x, :y])

    assert_equal [:t, [:a, :b], []],       task(:t, :a, :b)
    assert_equal [:t, [], [:x]],           task(:t, :needs => :x)
    assert_equal [:t, [:a, :b], [:x]],     task(:t, :a, :b, :needs => :x)
    assert_equal [:t, [:a, :b], [:x, :y]], task(:t, :a, :b, :needs => [:x, :y])

    assert_equal [:t, [:a, :b], []],       task(:t, [:a, :b])
    assert_equal [:t, [:a, :b], [:x]],     task(:t, [:a, :b] => :x)
    assert_equal [:t, [:a, :b], [:x, :y]], task(:t, [:a, :b] => [:x, :y])
  end

  def task(*args)
    tm = Rake::TestCase::TaskManager.new
    tm.resolve_args(args)
  end
end
