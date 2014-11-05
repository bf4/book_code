#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/kernel' unless defined? silence_warnings

class KernelTest < Test::Unit::TestCase
  def test_silence_warnings
    silence_warnings { assert_nil $VERBOSE }
    assert_equal 1234, silence_warnings { 1234 }
  end

  def test_silence_warnings_verbose_invariant
    old_verbose = $VERBOSE
    silence_warnings { raise }
    flunk
  rescue
    assert_equal old_verbose, $VERBOSE
  end


  def test_enable_warnings
    enable_warnings { assert_equal true, $VERBOSE }
    assert_equal 1234, enable_warnings { 1234 }
  end

  def test_enable_warnings_verbose_invariant
    old_verbose = $VERBOSE
    enable_warnings { raise }
    flunk
  rescue
    assert_equal old_verbose, $VERBOSE
  end


  def test_silence_stderr
    old_stderr_position = STDERR.tell
    silence_stderr { STDERR.puts 'hello world' }
    assert_equal old_stderr_position, STDERR.tell
  end

  def test_silence_stderr_with_return_value
    assert_equal 1, silence_stderr { 1 }
  end
end
