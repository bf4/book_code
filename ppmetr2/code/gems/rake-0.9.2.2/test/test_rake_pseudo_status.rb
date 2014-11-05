#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)

class TestRakePseudoStatus < Rake::TestCase
  def test_with_zero_exit_status
    s = Rake::PseudoStatus.new
    assert_equal 0, s.exitstatus
    assert_equal 0, s.to_i
    assert_equal 0, s >> 8
    refute s.stopped?
    assert s.exited?
  end

  def test_with_99_exit_status
    s = Rake::PseudoStatus.new(99)
    assert_equal 99, s.exitstatus
    assert_equal 25344, s.to_i
    assert_equal 99, s >> 8
    refute s.stopped?
    assert s.exited?
  end
end
