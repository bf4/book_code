#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/date'

class DateExtCalculationsTest < Test::Unit::TestCase
  def test_to_s
    assert_equal "21 Feb",            Date.new(2005, 2, 21).to_s(:short)
    assert_equal "February 21, 2005", Date.new(2005, 2, 21).to_s(:long)
  end
  
  def test_to_time
    assert_equal Time.local(2005, 2, 21), Date.new(2005, 2, 21).to_time
  end
  
  def test_to_date
    assert_equal Date.new(2005, 2, 21), Date.new(2005, 2, 21).to_date
  end
end